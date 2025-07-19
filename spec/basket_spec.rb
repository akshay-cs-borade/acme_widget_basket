require 'rspec'
require_relative '../lib/product'
require_relative '../lib/basket'
require_relative '../lib/offer/red_widget_offer'
require_relative '../lib/delivery/tiered_delivery'

RSpec.describe Basket do
  let(:catalog) do
    [
      Product.new("R01", "Red Widget", 32.95),
      Product.new("G01", "Green Widget", 24.95),
      Product.new("B01", "Blue Widget", 7.95)
    ]
  end

  let(:delivery) do
    TieredDelivery.new([
      { threshold: 90, fee: 0.0 },
      { threshold: 50, fee: 2.95 },
      { threshold: 0, fee: 4.95 }
    ])
  end

  let(:offers) { [RedWidgetOffer.new] }

  def total_for(*codes)
    basket = Basket.new(product_catalog: catalog, delivery_strategy: delivery, offers: offers)
    codes.each { |code| basket.add(code) }
    basket.total
  end

  it 'calculates total for B01, G01' do
    expect(total_for("B01", "G01")).to eq("$37.85")
  end

  it 'calculates total for R01, R01' do
    expect(total_for("R01", "R01")).to eq("$54.38")
  end

  it 'calculates total for R01, G01' do
    expect(total_for("R01", "G01")).to eq("$60.85")
  end

  it 'calculates total for B01, B01, R01, R01, R01' do
    expect(total_for("B01", "B01", "R01", "R01", "R01")).to eq("$98.28")
  end
end
