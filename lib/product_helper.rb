# frozen_string_literal: true

require 'pastel'

module ProductHelper
  path = File.dirname(__FILE__).split('/')
  path.pop
  PRODUCT_DATABASE = "#{path.join('/')}/public/products.json"
  FILE_READ = File.read(PRODUCT_DATABASE)
  INPUTS = %i[product category quantity quantity_per_box item_weight].freeze
  DELETE_CHOICES = %i[product id].freeze
  HEADINGS = %i[id product category quantity quantity_per_box item_weight box_weight_in_kg].freeze
  color = Pastel.new.white.on_blue.bold.detach
  PROMPT = TTY::Prompt.new(active_color: color)
  delete_color = Pastel.new.white.on_red.bold.detach
  PROMPT_DELETE = TTY::Prompt.new(active_color: delete_color, symbols: { radio_on: 'x' })
end

# Users\alves\Desktop\ruby\my_warehouse_stock_app\lib
