# frozen_string_literal: true

require 'json'
require_relative 'product_helper'
require_relative 'product'

class ProductRepository
  attr_reader :products

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
        product['quantity per box'],
        product['item weight'],
        product['box weight']
      )
    end
  end

  # def write_product
  #   data = @products.map do |product|
  #     {
  #       id: product.id,
  #       product: product.product,
  #       category: product.category,
  #       qantity_per_box: product.qantity_per_box,
  #       item_weight: product.item_weight,
  #       box_weight: product.box_weight
  #     }
  #   end
  #   File.write(PRODUCTS_DATABASE, JSON.pretty_generate(data))
  # end

  # def create_bookmark
  #   bookmark = Bookmark.bookmark_user_input
  #   @bookmarks << Bookmark.new(
  #     @bookmarks.length + 1,
  #     bookmark[:title],
  #     bookmark[:url],
  #     validate_tags(bookmark[:tags]),
  #     bookmark[:description]
  #   )
  # end

  # def validate_tags(tags)
  #   tags.split(',')
  # end
end
