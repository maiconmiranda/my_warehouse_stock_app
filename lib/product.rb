# frozen_string_literal: true

require_relative 'product_helper'

class Product
  attr_accessor :id, :product, :category, :quantity, :quantity_per_box, :item_weight, :box_weight

  include ProductHelper

  def initialize(id, product, category, quantity, quantity_per_box, item_weight, _box_weight = 0)
    @id = id
    @product = product
    @category = category
    @quantity = quantity
    @quantity_per_box = quantity_per_box
    @item_weight = item_weight
    @box_weight = box_weight_sum
    # @in = In
    # @out = Out
  end

  def to_a
    [@id, @product, @category, @quantity, @quantity_per_box, @item_weight, @box_weight]
  end

  def box_weight_sum
    num1 = @quantity_per_box
    num2 = @item_weight
    sum = num1 * num2
    sum
  end

  def increase_quantity
    puts 'How much you would like to increase the quantity?'
    increment = gets.chomp.to_i
    @quantity += increment
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
