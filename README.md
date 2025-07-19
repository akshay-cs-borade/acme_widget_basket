
# 🛒 Acme Widget Co – Basket Pricing System

A modular, testable Ruby implementation of a basket pricing system for **Acme Widget Co**.

---

## ✅ Features

- 🛍️ Product catalog support
- 🎁 Extensible offer system (e.g. "Buy 1 Red Widget, get 2nd half price")
- 🚚 Tiered delivery fee rules
- 🔌 Clean separation of concerns
- 🧪 RSpec test suite for pricing logic

---

## 📦 Product Catalog

| Product       | Code | Price  |
|---------------|------|--------|
| Red Widget    | R01  | $32.95 |
| Green Widget  | G01  | $24.95 |
| Blue Widget   | B01  | $7.95  |

---

## 📋 Delivery Rules

| Basket Total      | Delivery Fee |
|-------------------|--------------|
| < $50             | $4.95        |
| $50 – $89.99      | $2.95        |
| ≥ $90             | FREE         |

---

## 🎁 Offer Rules

- **Buy One Red Widget (R01), Get the Second Half Price**
  - Applies to every second R01 item in the basket.

---

## 🔧 How It Works

### Initialize a Basket

```ruby
catalog = [
  Product.new("R01", "Red Widget", 32.95),
  Product.new("G01", "Green Widget", 24.95),
  Product.new("B01", "Blue Widget", 7.95)
]

delivery = TieredDelivery.new([
  { threshold: 90, fee: 0.0 },
  { threshold: 50, fee: 2.95 },
  { threshold: 0,  fee: 4.95 }
])

offers = [RedWidgetOffer.new]

basket = Basket.new(
  product_catalog: catalog,
  delivery_strategy: delivery,
  offers: offers
)
````

### Add Products and Get Total

```ruby
basket.add("R01")
basket.add("R01")
puts basket.total  # => "$54.38"
```

---

## 🚀 Getting Started

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/acme-widget-basket.git
   cd acme-widget-basket
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Run the app**

   ```bash
   ruby main.rb
   ```

---

## 🧪 Run Tests

RSpec is used to verify pricing logic:

```bash
bundle exec rspec
```

---

## 🔍 Example Output

| Products in Basket      | Expected Total |
| ----------------------- | -------------- |
| B01, G01                | \$37.85        |
| R01, R01                | \$54.38        |
| R01, G01                | \$60.85        |
| B01, B01, R01, R01, R01 | \$98.28        |

---

## 💡 Assumptions

* Prices are precise using `BigDecimal` for currency safety.
* Delivery fee calculated **after** applying offer discounts.
* Only one active offer (R01) is implemented, but the system supports many.
* Offers and delivery logic are fully decoupled from `Basket`.

---

## 📁 Project Structure

```
lib/
├── product.rb
├── basket.rb
├── offer/
│   ├── base_offer.rb
│   └── red_widget_offer.rb
├── delivery/
│   ├── base_delivery.rb
│   └── tiered_delivery.rb
spec/
└── basket_spec.rb
main.rb
```

---

## 📚 Dependencies

* Ruby `>= 2.6`
* [rspec](https://github.com/rspec/rspec) – for testing
* [pry](https://github.com/pry/pry) – for debugging
* `BigDecimal` – native Ruby class for accurate currency math

---

## 👨‍💻 Author

**Acme Widget POC** developed by \[Akshay B].

---
