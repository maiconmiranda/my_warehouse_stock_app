# frozen_string_literal: true

require_relative 'product_helper'

# class that create all the instances for this app
class Product
  attr_reader :id, :product, :category, :quantity, :quantity_per_box, :item_weight, :box_weight

  include ProductHelper

  def initialize(id, product, category, quantity, quantity_per_box, item_weight, _box_weight = 0)
    @id = id
    @product = product
    @category = category
    @quantity = quantity
    @quantity_per_box = quantity_per_box
    @item_weight = item_weight
    @box_weight = box_weight_sum
  end

  def to_a
    [@id, @product, @category, @quantity, @quantity_per_box, @item_weight, @box_weight]
  end

  # returns the total value for box_weight
  def box_weight_sum
    num1 = @quantity_per_box
    num2 = @item_weight
    sum = num1 * num2
    sum.round(2)
  end

  def increment(value)
    @quantity += value
  end

  def decrease(value)
    @quantity -= value
  end

  def self.product_user_input
    prompt = PROMPT_ADD
    product = prompt.collect do
      key(:product).ask('Type the product name: ')
      key(:category).ask('Type the category: ')
      key(:quantity).ask('Type the quantity: ', convert: :int)
      key(:quantity_per_box).ask('Type the quantity_per_box: ', convert: :float)
      key(:item_weight).ask('Type the item_weight: ', convert: :float)
    end
    product
  end
end

