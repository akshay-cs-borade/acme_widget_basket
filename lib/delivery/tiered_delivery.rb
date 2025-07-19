class TieredDelivery
  def initialize(rules)
    @rules = rules.sort_by { |r| r[:threshold] }
  end

  def fee_for(subtotal)
    @rules.reverse_each do |rule|
      return rule[:fee] if subtotal >= rule[:threshold]
    end
    0
  end
end