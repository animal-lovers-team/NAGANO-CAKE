module ApplicationHelper

   def total_price(totals)
    price = 0
    totals.each do |total|
      price  +=  sub_price(total)
     end
     return price
   end


   def billing(order)
    total_price(current_customer) + order.postage
   end
end
