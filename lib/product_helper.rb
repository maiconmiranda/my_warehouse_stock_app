# frozen_string_literal: true

require 'pastel'
require 'colorize'

module ProductHelper
  path = File.dirname(__FILE__).split('/')
  path.pop
  PRODUCT_DATABASE = "#{path.join('/')}/public/products.json"
  FILE_READ = File.read(PRODUCT_DATABASE)
  DELETE_CHOICES = %i[product id].freeze

  INPUTS = %i[product category quantity quantity_per_box item_weight].freeze
  headings = %w[id product category quantity quantity_per_box item_weight box_weight_in_kg]

  HEADINGS = headings.map { |x| x.colorize(:green)}

  color = Pastel.new.white.on_blue.bold.detach
  PROMPT = TTY::Prompt.new(active_color: color)

  delete_color = Pastel.new.white.on_red.bold.detach
  PROMPT_DELETE = TTY::Prompt.new(active_color: delete_color, symbols: { radio_on: 'x' })

  add_color = Pastel.new.on_cyan.bold.detach
  PROMPT_ADD = TTY::Prompt.new(active_color: add_color, symbols: { radio_on: 'x' })

  in_out_color = Pastel.new.on_yellow.bold.detach
  PROMPT_IN_OUT = TTY::Prompt.new(active_color: in_out_color, symbols: { radio_on: 'x' })

end
