# frozen_string_literal: true

module ProductHelper
  path = File.dirname(__FILE__).split('/')
  path.pop
  PRODUCT_DATABASE = "#{path.join('/')}/public/products.json"
  # INPUTS = %i[title url tags description].freeze
  HEADINGS = %i[id product category quantity quantity_per_box item_weight box_weight].freeze
  # PROMPT = TTY::Prompt.new
end
