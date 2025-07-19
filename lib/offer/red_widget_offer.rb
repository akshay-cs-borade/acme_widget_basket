class RedWidgetOffer
  def apply(items)
    reds, others = items.partition { |p| p.code == 'R01' }
    reds = reds.sort_by(&:price)

    adjusted_reds = reds.each_with_index.map do |item, index|
      if index.odd?
        Product.new(item.code, item.name, item.price / 2.0)
      else
        item
      end
    end

    others + adjusted_reds
  end
end