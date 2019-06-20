class ApplicationController < ActionController::Base
  # create Visit Confirm Button
  def create_confirm_button(users_shops_id)
    confirm_button = {
      type: "template",
      altText: "Confirm",
      template: {
        type: "confirm",
        text: "行きたいですか？",
        actions: [
          {
            type: "message",
            label: "Yes",
            text: "Yes/#{users_shops_id}"
          },
          {
            type: "message",
            label: "No",
            text: "No/#{users_shops_id}"
          }
        ]
      }
    }
    return confirm_button
  end
  # create Quick Reply
  def create_quick_reply
    genres = [
      ["ラーメン", "ramen"],
      ["中華", "chinese"],
      ["洋食", "western"],
      ["和食", "japanese"],
      ["おまかせ", "random"]
    ]
    items = []
    genres.each_with_index do |g, i|
      items << {
        type: "action",
        imageUrl: "https://s3-ap-northeast-1.amazonaws.com/linebot-hiyoura/img/genre/#{i+1}_#{g[1]}.jpg",
        action: {
          type: "message",
          label: g[0],
          text: g[0]
        }
      }
    end
    quick_reply = {
      type: "text",
      text: "選んでね",
      quickReply: {
        items: items
      }
    }
    return quick_reply
  end

  # レビュー数に応じて星数を変える
  def review_star(review, flag)
     ## 初期化
    if flag==1
      site_of_review = {
        type: "text",
        text: "食べログ",
        size: "sm"
      }
    else
      site_of_review = {
        type: "text",
        text: "Google",
      	size: "sm"
      }
    end
    review_array = [site_of_review]
    ## レビュー数によって星数を変える
    gold_star = {
      type: "icon",
      size: "sm",
      url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
    }
    gray_star = {
      type: "icon",
      size: "sm",
      url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
    }
    for i in 1..5
      if i <= review.round
        review_array << gold_star
      else
        review_array << gray_star
      end
    end
    ## レビュー数(小数点第一位まで)
    number_of_review = {
      type: "text",
      text: review.to_s,
      size: "sm",
      color: "#999999",
      margin: "md",
      flex: 0
    }
    review_array << number_of_review
    return review_array
  end

  # 営業日・定休日
  def opening_hours(obj)
    n = Time.zone.now 
    # 曜日を決定 (dow = Day Of the Week)
    dow = %w(日 月 火 水 木 金 土 日)[n.wday]
    # 第何周目か
    week = n.day/7 + 1
    # 第何曜日を決定
    w_dow = week.to_s + dow
    # 定休日
    if obj.holiday.include?(w_dow) || obj.holiday.include?(dow)
      status_image = {
        type: "icon",
        size: "sm",
        url: "https://s3-ap-northeast-1.amazonaws.com/linebot-hiyoura/img/999_red_circle.jpg"
      }
      status_text = {
        type: "text",
        text: "#{n.month}/#{n.day} 定休日",
        margin: "md",
        size: "sm"
      }
      return [status_image, status_text]
    # 営業日
    else
      status_image = {
        type: "icon",
        size: "sm",
        url: "https://s3-ap-northeast-1.amazonaws.com/linebot-hiyoura/img/999_green_circle.jpg"
      }
      status_text = {
        type: "text",
        text: "#{n.month}/#{n.day} 営業日",
        margin: "md",
        size: "sm"
      }
      obj.opening_hours.each do |oh|
        if oh.day_of_the_week.nil? || oh.day_of_the_week==dow
          if oh.open_time_1 && oh.close_time_1
            opening_hours_1 = {
              type: "text",
              text: oh.open_time_1 + "~" + oh.close_time_1,
              size: "sm",
              color: "#999999",
              margin: "md",
              flex: 0
            }
          else
            opening_hours_1 = {
              type: "text",
              text: "不明",
              size: "sm",
              color: "#999999",
              margin: "md",
              flex: 0
            }
          end
          if oh.open_time_2 && oh.close_time_2
            opening_hours_2 = {
              type: "text",
              text: oh.open_time_2 + "~" + oh.close_time_2,
              size: "sm",
              color: "#999999",
              margin: "md",
              flex: 0
            }
            return [status_image, status_text, opening_hours_1, opening_hours_2]
          end
          return [status_image, status_text, opening_hours_1]
        end
      end
    end
  end

  # お店があるときの処理
  def exist_shop_process(shop, confirm_button)
    # Sub Contents
    ## 席
    if shop.seat
      shop_seat = "#{shop.seat.to_s}席"
    else
      shop_seat = "--席"
    end
    ## 各要素を配列に格納
    sub_contents_items = [
      ["座席", shop_seat],
      ["テーブル", shop.table],
      ["参考メニュー", shop.reference_menu],
      ["参考価格", "#{shop.reference_price.to_s}円"],
      ["系統", shop.category.feature_1],
      ["特徴", shop.category.feature_2]
    ]
    sub_contents = []
    sub_contents_items.each do |sci|
      sub_contents << {
        type: "box",
        layout: "baseline",
        spacing: "sm",
        contents: [
          {
            type: "text",
            text: "【#{sci[0]}】",
            color: "#aaaaaa",
            size: "sm",
            flex: 3
          },
          {
            type: "text",
            text: sci[1],
            wrap: true,
            color: "#666666",
            size: "sm",
            flex: 3
          }
        ]
      }
    end

    # Main Contents
    ## 各要素を配列に格納(営業時間, 食べログ レビュー, Googleレビュー)
    main_contents_items = [opening_hours(shop), review_star(shop.tabelog_review.round(2), 1), review_star(shop.google_review.round(2), 2)]
    ## 店名
    main_contents = [{
        type: "text",
        text: shop.shop_name,
        weight: "bold",
        size: "xl"
    }]
    main_contents_items.each do |mci|
      main_contents << {
        type: "box",
        layout: "baseline",
        margin: "md",
        contents: mci
      }
    end
    main_contents << {
      type: "box",
      layout: "vertical",
      margin: "lg",
      spacing: "sm",
      contents: sub_contents
    }

    # Call URL Button
    call_url_button = []
    ## 電話予約
    if shop.reserve=="可" && shop.telephone_number
      line_out = "line://call/81/" + shop.telephone_number
      call_url_button << {
        type: "button",
        style: "link",
        height: "sm",
        action: {
          type: "uri",
          label: "電話予約",
          uri: line_out
        }
      }
    end
    ## 食べログURL
    call_url_button << {
      type: "button",
      style: "link",
      height: "sm",
      action: {
        type: "uri",
        label: "食べログ",
        uri: shop.tabelog_url
      }
    }
    ## 公式URL
    if shop.official_url
      call_url_button << {
        type: "button",
        style: "link",
        height: "sm",
        action: {
          type: "uri",
          label: "公式",
          uri: shop.official_url
        }
      }
    end
    ## スペーサー
    call_url_button << {
      type: "spacer",
      size: "sm"
    }

    # 基本情報
    message1 = {
      type: "flex",
      altText: "ひようら君のお店紹介",
      contents: {
        type: "bubble",
        ## 画像
        hero: {
          type: "image",
          url: "https://s3-ap-northeast-1.amazonaws.com/linebot-hiyoura/img/#{shop.image_file_name}",
          size: "full",
          aspectRatio: "20:13",
          aspectMode: "cover",
          action: {
            type: "uri",
            uri: shop.tabelog_url
          }
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: main_contents
        },
        footer: {
          type: "box",
          layout: "vertical",
          spacing: "sm",
          contents: call_url_button,
          flex: 0
        }
      }
    }
    # 位置情報
    message2 = {
      type: "location",
      title: shop.shop_name,
      address: shop.google_map_url,
      latitude: shop.latitude.to_f,
      longitude: shop.longnitude.to_f
    }
    return [message1, message2, confirm_button]
  end
end
