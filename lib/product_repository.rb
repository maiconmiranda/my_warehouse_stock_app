# frozen_string_literal: true

require 'tty-prompt'
require 'json'
require_relative 'product_helper'
require_relative 'product'

class ProductFile
  attr_accessor :products

  include ProductHelper

  def initialize
    @products = read_products
  end

  def read_products
    data = FILE_READ
    JSON.parse(data).map do |product|
      Product.new(
        product['id'],
        product['product'],
        product['category'],
        product['quantity'],
        product['quantity_per_box'],
        product['item_weight'],
        product['box_weight']
      )
    end
  end

  def write_product
    data = @products.map do |product|
      {
        id: product.id,
        product: product.product,
        category: product.category,
        quantity: product.quantity,
        quantity_per_box: product.quantity_per_box,
        item_weight: product.item_weight,
        box_weight: product.box_weight
      }
    end
    File.write(PRODUCT_DATABASE, JSON.pretty_generate(data))
  end

  def create_product
    product = Product.product_user_input
    @products << Product.new(
      @products.length + 1,
      product[:product],
      product[:category],
      product[:quantity].to_i,
      product[:quantity_per_box].to_f,
      product[:item_weight].to_f
    )
  end

  def select_delete
    index = FILE_READ
    delete_prompt = PROMPT_DELETE
    selected = JSON.parse(index).find do |item|
      item['product'] == delete_prompt.select('Which Product you want to delete?',
                                              JSON.parse(index).map { |product| product['product'] })
    end
    p selected
    i = JSON.parse(index).index { |item| item == selected }
    @products.delete_at(i)
  end

  def manage_menu
    prompt2 = PROMPT_DELETE
    prompt2.select('Choose one option below') do |menu|
      menu.choice({ name: 'Edit product', value: '1' })
      menu.choice({ name: 'Delete Product', value: '2' })
      menu.choice({ name: 'Back to main menu', value: '3' })
    end
  end

  def menu_selection
    loop do
      case manage_menu
      when '1'
        puts 'not available'
        manage_menu
      when '2'
        select_delete
      when '3'
        exit
      end
    end
  end
end
