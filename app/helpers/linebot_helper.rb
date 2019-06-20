module LinebotHelper
  
  # json.set! :site_of_review do
  #   json.type "text"
  #   json.text "食べログ"
  #   json.size "sm"
  # end
  
  # json.set! :message1 do |j|
  #   j.type "flex"
  #   j.altText "_obj.shop_name"
  #   j.contents do |j|
  #     j.type "bubble"
  #     # 画像
  #     j.hero do |j|
  #       j.type "image"
  #       j.url "_image_path"
  #       j.size "full"
  #       j.aspectRatio "20:13"
  #       j.aspectMode "cover"
  #       j.cover do |j|
  #         j.type "uri"
  #         j.uri "_obj.tabelog_url"
  #       end
  #     end
  #     # 本文
  #     j.body do |j|
  #       j.type "box"
  #       j.layout "vertical"
  #       j.contents do |j|
  #         # 店名
  #         j.type "text"
  #         j.text "_obj.shop_name"
  #         j.weight "bold"
  #         j.size "xl"
  #         # 営業時間
  #         j.type "box"
  #         j.layout "baseline"
  #         j.margin "md"
  #         j.contents "_opening_hours(obj)"
  #         # 食べログ レビュー
  #         j.type "box"
  #         j.layout "baseline"
  #         j.margin "md"
  #         j.contents review_star(obj.tabelog_review.round(2), 1)
  #         # Google レビュー
  #         j.type "box"
  #         j.layout "baseline"
  #         j.margin "md"
  #         j.contents review_star(obj.google_review.round(2), 2)
  #         # その他
  #         j.type "box"
  #         j.layout "vertical"
  #         j.margin "lg"
  #         j.spacing "sm"
  #         j.contents do |j|
  #           # 座席
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【座席】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text shop_seat
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #           # テーブル
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【テーブル】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text obj.table
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #           # 参考メニュー
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【参考メニュー】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text obj.reference_menu
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #           # 参考価格
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【参考価格】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text "#{obj.reference_price.to_s}円"
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #           # 系統
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【系統】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text obj.category.feature_1
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #           # 特徴
  #           j.type "box"
  #           j.layout "baseline"
  #           j.spacing "sm"
  #           j.contents do |j|
  #             j.type "text"
  #             j.text "【特徴】"
  #             j.color "#aaaaaa"
  #             j.size "sm"
  #             j.flex 3
  #             #
  #             j.type "text"
  #             j.text obj.category.feature_2
  #             j.wrap true
  #             j.color "#666666"
  #             j.size "sm"
  #             j.flex 3
  #           end
  #         end
  #       end
  #     end
  #     # フッター
  #     j.footer do |j|
  #       j.type "box"
  #       j.layout "vertical"
  #       j.spacing "sm"
  #       j.contents call_url_button
  #       j.flex 0
  #     end
  #   end
  # end
end
