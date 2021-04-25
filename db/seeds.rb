# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
    Customer.create!(
      email: "test#{n + 1}@test.com",
      first_name: "名#{n + 1}",
      last_name: "姓#{n + 1}",
      kana_first_name: "セイ",
      kana_last_name: "メイ",
      password: "123456",
      postal_code: "1234567",
      street_address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
      phone_number: "09012345678"
    )
end

  Admin.create!(
    email: "admin1@mail",
    password: "111111"
  )
  
   Genre.create!(
    name: "ホールケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "パンダケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "チーズケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "モンブラン",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "ミルクレープ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "ミルフィーユ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "チョコレートケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "ロールケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "マカロン",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "ケーキ",
    is_valid: [['有効', true], ['無効', false]]
  )
  Genre.create!(
    name: "シュークリーム",
    is_valid: [['有効', true], ['無効', false]]
  )
  
  10.times do |n|
    Product.create!(
      genre_id: "1",
      name: "ショートケーキ#{n + 1}",
      introduction: "美味しいショートケーキ",
      price: "1500",
      image: open("./app/assets/images/cake.jpeg"),
      is_active: "true"
    )
  end
  
  9.times do |n|
  Product.create!(
    genre_id: "1",
    name: "チョコケーキ#{n+1}",
    introduction: "チョコ",
    price: "3000",
    image: open("./app/assets/images/cake.jpeg"),
    is_active: "true"
  )
end

9.times do |n|
  Address.create!(
    name: "test#{n + 1}",
    postal_code: "123456#{n + 1}",
    address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
    customer_id: n + 1
    )
end

5.times do |n|
  Order.create!(
    customer_id: n +1,
    shipping_address: "東京都渋谷区神南1丁目19-11 パークウェースクエア2 4階#{n + 1}",
    postal_code: "123456#{n + 1}",
    name: "test#{n + 1}",
    postage: "800",
    total_price: "#{1000 + (n * 1000) +800}",
    payment_method: "クレジットカード"
  )
end

5.times do |n|
  OrderDatail.create!(
    product_id: n + 1,
    order_id: n + 1,
    quantity: n + 3,
    subprice: "#{1000 + (n * 1000)}"
  )
end
