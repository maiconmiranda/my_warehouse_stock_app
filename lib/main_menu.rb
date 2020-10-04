# frozen_string_literal: true

require 'tty-prompt'
require 'terminal-table'
require 'tty-font'
require 'colorize'
require_relative 'product_helper'
require_relative 'product_repository'
require_relative 'in_out'

# class for main menu option
class MainMenu
  include ProductHelper

  def initialize
    @product_repository = ProductFile.new
  end

  def intro
    font = TTY::Font.new(:doom)
    puts font.write('Warehouse').colorize(color: :black, background: :blue)
    puts font.write('              Stock              ').colorize(color: :black, background: :blue)
    puts font.write('                       App               ').colorize(color: :black, background: :blue)
  end

  # prints a list of products
  def terminal_table
    rows = @product_repository.read_products.map(&:to_a)
    table = TTY::Table.new(header: HEADINGS, rows: rows)
    puts table.render(:unicode, alignments: :center, padding: [1, 2, 1, 2]) do |renderer|
      renderer.border.style = :green
    end
  end

  def selection
    prompt = PROMPT
    prompt.select('Welcome to My Warehouse Stock app!') do |menu|
      menu.choice({ name: 'Add new product', value: '1' })
      menu.choice({ name: 'View my stock list', value: '2' })
      menu.choice({ name: 'Manage my stock', value: '3' })
      menu.choice({ name: 'In and Out', value: '4' })
      menu.choice({ name: 'Display In and Out report', value: '5' })
      menu.choice({ name: 'exit', value: '6' })
    end
  end

  def router
    puts intro
    loop do
      case selection
      when '1'
        @product_repository.create_product
        @product_repository.write_product
      when '2'
        puts 'View my stock list'
        terminal_table
      when '3'
        @product_repository.menu_selection
        @product_repository.write_product
      when '4'
        puts 'In and Out'
        InOut.new.in_out_selection
      when '5'
        puts 'Display In and Out report'
      when '6'
        exit
      end
    end
  end
end

APP = MainMenu.new
APP.router
