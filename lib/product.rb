class Products

  INPUTS = %i[product_name category quantity quantity_per_box item_weight]

  def initialize(id, product_name, category, quantity, quantity_per_box, item_weight)
    @id = id
    @product_name = product_name
    @category = category
    @quantity = quantity
    @quantity_per_box = quantity_per_box
    @item_weight = item_weight
    @box_weight = item_weight * quantity_per_box
  end


  def to_a
    [@id, @product_name, @category, @quantity, @quantity_per_box, @item_weight, @box_weight]
  end

  def self.products_user_input
    product = {}
    INPUTS.each do |input|
      puts "Whats the #{input}"
      print '> '
      product[input] = gets.chomp
    end
    product
  end
end

