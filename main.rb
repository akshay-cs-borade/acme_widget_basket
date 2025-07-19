# main.rb
require 'pry'
require_relative 'lib/product'
require_relative 'lib/basket'
require_relative 'lib/offer/red_widget_offer'
require_relative 'lib/delivery/tiered_delivery'

# Setup catalog
catalog = [
  Product.new("R01", "Red Widget", 32.95),
  Product.new("G01", "Green Widget", 24.95),
  Product.new("B01", "Blue Widget", 7.95)
]

# Delivery pricing rules
delivery = TieredDelivery.new([
  { threshold: 90, fee: 0.0 },
  { threshold: 50, fee: 2.95 },
  { threshold: 0, fee: 4.95 }
])

# Offers
offers = [RedWidgetOffer.new]

# Create basket
basket = Basket.new(product_catalog: catalog, delivery_strategy: delivery, offers: offers)

# Add items
%w[B01 B01 R01 R01 R01].each { |code| basket.add(code) }

# Print total
puts "Total: #{basket.total}"