module ApplicationHelper
<<<<<<< HEAD
=======

  def current_cart
    @cart_items = current_customer.cart_items
  end

  # 小数点切り捨てはfloor,３桁区切りはto_s(:delimited)
  # 税込の計算
>>>>>>> 2c965ac29046cff43021baf87e41ced314db798c
  def tax_price(price)
    (price * 1.1).floor
  end

<<<<<<< HEAD
  def sub_price(sub)
    (tax_price(sub..price) * sub.quantity)
  end

  def total_price(totals)
    price = 0
    totals.each do |total|
      price += sub_price(total)
    end
    return price
  end
  
  def current_cart
    @cart_items = current_customer.cart_items
  end
  
  def billing(order)
    total_price(current_cart) + order.postage 
=======
  # 小計の計算
  def sub_price(sub)
    (tax_price(sub.product.price) * sub.quantity)
  end

  # 合計金額の計算
  def total_price(totals)
    price = 0
    totals.each do |total|
      price  +=  sub_price(total)
    end
    return price
  end

  # 請求額の計算
  def billing(order)
    total_price(current_cart) + order.postage
>>>>>>> 2c965ac29046cff43021baf87e41ced314db798c
  end
end

