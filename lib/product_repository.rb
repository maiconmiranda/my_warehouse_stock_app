# frozen_string_literal: true

require 'tty-prompt'
require 'json'
require 'tty-box'
require 'pastel'
require 'tty-table'
require_relative 'product_helper'
require_relative 'product'

# class contains methods to work with json file, also delete and edit options
class ProductFile
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
      product[:quantity],
      product[:quantity_per_box],
      product[:item_weight],
      product[:box_weight]
    )
  end

   # display confirmation message after delete
   def box_del_confirmation
    print TTY::Cursor.clear_screen
    box_del = TTY::Box.frame(
      top: 2,
      left: 2,
      width: 50,
      height: 5,
      border: :thick,
      align: :center,
      padding: 1,
      title: {
        top_left: ' success '
      },
      style: {
        fg: :white,
        bg: :red,
        border: {
          fg: :bright_yellow,
          bg: :red
        }
      }
    ) do
      'Product deleted'
    end
    puts box_del
  end

  # gets the product name to display in tty-prompt for edit and delete options
  def product_name
    name = []
    @products.map do |product|
      name << product.product
    end
    name
  end

  # gets user's input and return array index of the selected choice for edit option
  def selection_to_edit
    delete_prompt = PROMPT_ADD
    choice = delete_prompt.select('Which Product you want to edit?', product_name) do |menu|
      menu.enum '.'
    end
    @products.index { |h| h.product == choice }
  end

  # confirms delete option and delete a selected hash by index
  def confirm_and_delete
    selected = selection_to_edit
    p selected
    prompt = PROMPT_DELETE
    result = prompt.yes?('Are you sure you want delete?')
    if result
      @products.delete_at(selected)
    else
      manage_menu
    end
  end

  # confirms edit option, delete select and create a new product
  def replace_product
    edit_selected = selection_to_edit
    p edit_selected
    prompt = PROMPT_DELETE
    result = prompt.yes?('Are you sure you want edit product?')
    if result
      @products.delete_at(edit_selected)
      create_product
      write_product
    else
      manage_menu
    end
  end

  # edit menu
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
        replace_product
        box_edit_confirmation
        write_product
        MainMenu.new.router
      when '2'
        confirm_and_delete
        box_del_confirmation
        write_product
        MainMenu.new.router
      when '3'
        MainMenu.new.router
      end
    end
  end

end
