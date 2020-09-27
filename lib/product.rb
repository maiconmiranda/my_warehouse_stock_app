# frozen_string_literal: true

require_relative 'product_helper'

class Product
  include ProductHelper

  attr_reader :id, :product, :category, :quantity, :quantity_per_box, :item_weight, :box_weight

  def initialize(id, product, category, quantity, quantity_per_box, item_weight, box_weight)
    @id = id
    @product = product
    @category = category
    @quantity = quantity
    @quantity_per_box = quantity_per_box
    @item_weight = item_weight
    @box_weight = box_weight
  end

  def to_a
    [@id, @product, @category, @quantity, @quantity_per_box, @item_weight, @box_weight]
  end

  def self.product_user_input
    product = {}
    INPUTS.each do |input|
      puts "Whats the #{input}"
      print '> '
      product[input] = gets.chomp
    end
    product
  end
end
