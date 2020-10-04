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

  # display confirmation message after edit
  def box_edit_confirmation
    print TTY::Cursor.clear_screen
    box_edit = TTY::Box.frame(
      top: 3,
      left: 3,
      width: 80,
      height: 5,
      border: :thick,
      align: :center,
      padding: 1,
      title: {
        top_left: ' success '
      },
      style: {
        fg: :black,
        bg: :green,
        border: {
          fg: :black,
          bg: :green
        }
      }
    ) do
      'The product you edited will be displayed at the end of the list'
    end
    puts box_edit
  end

  # display confirmation message after add or remove quantity
  def box_in_out_confirmation
    print TTY::Cursor.clear_screen
    box_in_out = TTY::Box.frame(
      top: 3,
      left: 5,
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
        bg: :blue,
        border: {
          fg: :white,
          bg: :blue
        }
      }
    ) do
      'Quantity changed'
    end
    puts box_in_out
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
      box_del_confirmation
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
      box_edit_confirmation
    else
      manage_menu
    end
    
  end

  # gets user's input and return array index of the selected choice for in and out option
  def selection_for_in_out
    delete_prompt = PROMPT_IN_OUT
    choice = delete_prompt.select('Which Product you want add/remove quantity?', product_name) do |menu|
      menu.enum '.'
    end
    @products.index { |h| h.product == choice }
  end

  # gets user input for in and out
  def in_new
    prompt = PROMPT_IN_OUT
    in_qty = prompt.collect do
      key(:in_out_qty).ask('Waht is the quantity to be added? ', convert: :integer)
    end
    in_qty
  end

  # increase quantity fo In option
  def increase_quantity
    @products[selection_for_in_out].increment(in_new[:in_out_qty])
    write_product
  end

  # decrease quantity fo In option
  def remove_quantity
    @products[selection_for_in_out].decrease(in_new[:in_out_qty])
  end

  # confirmation for In option
  def in_qty_add
    prompt = PROMPT
    result = prompt.yes?('Are you sure you want add quantity?')
    if result
      increase_quantity
      box_in_out_confirmation
    else
      in_out_menu
    end
    
  end

  # confirmation for Out option
  def out_qty_remove
    prompt = PROMPT_DELETE
    result = prompt.yes?('Are you sure you want remove quantity?')
    if result
      remove_quantity
      write_product
      box_in_out_confirmation
    else
      in_out_menu
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

  def in_out_menu
    prompt2 = PROMPT_IN_OUT
    prompt2.select('Choose one option below') do |menu|
      menu.choice({ name: 'In', value: '1' })
      menu.choice({ name: 'Out', value: '2' })
      menu.choice({ name: 'Back to main menu', value: '3' })
    end
  end

  def menu_selection
    loop do
      case manage_menu
      when '1'
        replace_product
        write_product
        MainMenu.new.router
      when '2'
        confirm_and_delete
        write_product
        MainMenu.new.router
      when '3'
        MainMenu.new.router
      end
    end
  end

  def in_out_selection
    loop do
      case in_out_menu
      when '1'
        in_qty_add
        MainMenu.new.router
      when '2'
        out_qty_remove
        MainMenu.new.router
      when '3'
        MainMenu.new.router
      end
    end
  end
end