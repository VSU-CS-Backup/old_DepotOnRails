class Order < ActiveRecord::Base
  # PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  # ...
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PaymentType.names

  has_many :line_items, :dependent => :destroy
  # ...
  # ...
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

acts_as_gmappable

  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
    "<h4>#{name}</h4>" << "<h4>#{address}</h4>"
  end

end
