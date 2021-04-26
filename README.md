# ながのCAKE（ECサイト）DMM WEBCAMPチーム開発フェイズ

長野県にある小さな洋菓子店、「ながのCAKE」の商品を通販するためのECサイト。  
元々近隣樹民が主な顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るようになった。  
InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。


#  通販について

- 通販では注文に応じて製作する受注生産型としています。  
- 現在通販での注文量は十分に対応可能な量のため、1日の受注量に制限は設けていません。  
- 送料は１配送につき全国一律８００円。  
- 友人や家族へのプレゼントなど、注文者の住所以外にも商品を発送することができます。  
- 支払い方法はクレジットカード、銀行振込から選択できます。

#  実装機能

-   ユーザー登録
-   ログイン・ログアウト
-   カート
-   商品一覧
-   商品検索
-   マイページ
-   購入履歴一覧・削除
-   パスワード再設定

# 使用方法

- (ssh) git clone git@github.com:animal-lovers-team/NAGANO-CAKE.git
- (https) git clone https://github.com/animal-lovers-team/NAGANO-CAKE.git
- cd NAGANO-CAKE
- bundle install
- rails db:migrate
- rake db:seed


## 作成者

- 高橋　幸来
- 奈良　将人
- 児玉　遥
