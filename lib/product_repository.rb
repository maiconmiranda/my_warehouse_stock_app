# frozen_string_literal: true

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
    data = File.read(PRODUCT_DATABASE)
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
end

# pop = ProductFile.new
# pop.create_product
# pop.write_product
# p pop
