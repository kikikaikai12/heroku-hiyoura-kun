class LinebotController < ApplicationController
  require 'line/bot'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  # ユーザー情報の取得
  def get_name(user_id)
    response = client.get_profile(user_id)
    case response
    when Net::HTTPSuccess then
      username = JSON.parse(response.body)['displayName']
      return username
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    # Quick Reply
    quick_reply = create_quick_reply()

    events = client.parse_events_from(body)
    events.each { |event|

      line_user_id = event['source']['userId']
      # get user profile
      profile = get_name(line_user_id)
      unless User.find_by(line_user_id: line_user_id)
        user = User.new(name: profile, line_user_id: line_user_id)
        user.save
      end

      if event['type'] == "follow"
        message = {
          type: 'text', 
          text: "#{profile}さん、はじめまして！\nぼくの名前は、ひようら君。\n日吉駅のご飯屋さんを紹介するよ。\n\n・「ラーメン」\n・「中華」\n・「洋食」\n・「和食」\n\nの4ジャンルの中から１つ選んでね！\nそのジャンルのお店を１つ紹介するよ！\nもし選ぶのが面倒になったら、\n\n・「おまかせ」\n\nを選んでね！\nジャンル関係なくお店を１つ紹介するよ！"
        }
      elsif event['type'] == "unfollow"
      else
        # ジャンル入力
        genre = event.message['text']
        # ジャンルの入力に応じて、数字を割り振る
        case genre
        when "ラーメン", "らーめん", "拉麺", "ramen", "Ramen"
          shops = Shop.where(genre: "ラーメン")
        when "チュウカ", "ちゅうか", "中華", "中", "chuka", "Chuka", "China", "Chinese"
          shops = Shop.where(genre: "中華")
        when "ヨウショク", "ようしょく", "洋食", "洋", "yoshoku", "Youshoku", "yoshoku", "Yoshoku", "europe", "Europe", "europian", "Europian"
          shops = Shop.where(genre: "洋食")
        when "ワショク", "わしょく", "和食", "和", "washoku", "Washoku", "nihon", "Nihon", "japan", "Japan", "japanese", "Japanese"
          shops = Shop.where(genre: "和食")
        when "おまかせ", "ランダム", "らんだむ", "完全ランダム", "完全おまかせ"
          shops = Shop.all
        else
          if genre.include?("/")
            # ボタンのIDを取得
            genre_split = genre.split("/")
            user_shop_id = genre_split[1].to_i
            user_shop = UsersShop.find(user_shop_id)
            if user_shop._button_pushed == false
              if genre_split[0] == "Yes"
                want_to_visit_counts = user_shop.want_to_visit + 1
                user_shop.update(want_to_visit: want_to_visit_counts, _button_pushed: true)
              elsif genre_split[0] == "No"
                user_shop.update(_button_pushed: true)
              end
            end
          else
            response = {
              type: 'text',
              text: "あなたが食べたいのは次の5つの内どれですか？"
            }
          end
        end
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if shops
            user_id = User.find_by(line_user_id: line_user_id).id
            # 行きたいボタンが押されるほど出やすくする
            shop_id_array = []
            shops.each do |s|
              # 全shopsのIDを格納
              shop_id_array << s.id
              # 行きたいボタンが押された回数だけIDを追加
              s.users_shops.where(user_id: user_id).each do |us|
                wtv = us.want_to_visit
                wtv.times do
                  shop_id_array << us.shop_id
                end
              end
            end
            p "************************"
            p shop_id_array
            p "************************"
            # 配列からランダムに取り出す
            shop_id = shop_id_array.sample
            shop = Shop.find(shop_id)
            # log
            if UsersShop.find_by(user_id: user_id, shop_id: shop.id)
              users_shop = UsersShop.find_by(user_id: user_id, shop_id: shop.id)
              users_shop.update(_button_pushed: false)
            else
              users_shop = UsersShop.new(message: genre, user_id: user_id, shop_id: shop.id)
              users_shop.save
            end
            # Visit Confirm Button
            confirm_button = create_confirm_button(users_shop.id)
            client.reply_message(event['replyToken'], exist_shop_process(shop, confirm_button))
          elsif response
            client.reply_message(event['replyToken'], [response, quick_reply])
          else
            client.reply_message(event['replyToken'], [quick_reply])
          end
        end
      when Line::Bot::Event::Follow
        # follow notice
        p "************************"
        p "follow"
        p "************************"
        client.reply_message(event['replyToken'], [message, quick_reply])
      when Line::Bot::Event::Unfollow
        # unfollow notice
        p "************************"
        p "unfollow"
        p "************************"
      end
    }
    head :ok
  end
end
