require_relative 'product'

class Basket
  def initialize(product_catalog:, offers: [], delivery_strategy:)
    @catalog = product_catalog.each_with_object({}) { |p, h| h[p.code] = p }
    @offers = offers
    @delivery_strategy = delivery_strategy
    @items = []
  end

  def add(code)
    product = @catalog[code]
    raise ArgumentError, "Unknown product code: #{code}" unless product
    @items << product.dup
  end

  def total
    items = @offers.inject(@items.dup) { |acc, offer| offer.apply(acc) }
    subtotal = items.sum(&:price)
    delivery_fee = @delivery_strategy.fee_for(subtotal)

    total = subtotal + delivery_fee
    format("$%.2f", total.round(2))
  end
end