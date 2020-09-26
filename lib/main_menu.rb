require 'tty-prompt'
require 'tty-font'
require 'colorize'

# class Main_menu

  # def initialize
  #   Main_menu::PROMPT
  # end

  def intro
    font = TTY::Font.new(:doom)
      puts font.write("Warehouse").colorize(:color => :black, :background => :blue)
      puts font.write("            Stock").colorize(:color => :black, :background => :blue)
      puts font.write("                   App").colorize(:color => :black, :background => :blue)
  end
  
  # def version
  #   TTY::Box.frame(title: { bottom_right: "v1.0"}) do
  #     "MY WAREHOUSE STOCK APP"
  #   end
  # end

  def selection
    prompt = TTY::Prompt.new
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
          puts "add new product"
        when '2'
          puts 'View my stock list'
        when '3'
          puts 'Manage my stock'
        when '4'
          puts 'In and Out'
        when '5'
          puts 'Display In and Out report'
        when '6'
          exit
        end
      end
  end
# end

router