# Warehouse Sotck App

# Github

https://github.com/maiconmiranda/my_warehouse_stock_app

## Installation and Setup

1. Install ruby, we recommend using [asdf](https://asdf-vm.com/)

2. Install [git](https://git-scm.com/downloads)

3. `git clone` the app to your home directory

```bash
git clone https://github.com/maiconmiranda/my_warehouse_stock_app.git
```

4. Run the `setup` executable file

```bash
~/my_warehouse_stock_app/bin/setup
```

5. Open your `.bash_profile` in a text editor

6. Add this line

```bash
export PATH=$PATH:$HOME/my_warehouse_stock_app/bin
```

7. Restart your terminal to make sure `.bash_profile` loads the app into your PATH

8. Run the `warehouse` executable to start the app

```bash
warehouse
```

## Software Development Plan

The purpose of this app is to have a control of your stock in your warehouse, been able to add products and quantity as well the inwards and outwards.

### Target Audience

Suitable for small stores or small warehouses that want to keep a simple track of goods in stock.
Go to Features to learn how to use the app.

# Features

## Welcome to My Warehouse Stock app.

This is the main menu, you will be able to select the choice using the up or down arrows in your keyboard, then just press enter

### What you would like to do?

1. Add new product
2. View my stock list
3. Manage my stock
4. In and Out
5. Exit.

## 1. Add new product

This menu will allow you to create a new product, the options are displayed below;

  - Create new
    - Product name
    - Category
    - Quantity
    - Quantity per box
    - Item weight
    - Box Weight
  
  For Quantity, Quantity per box and item weight, you must type only numbers, if you type any character, a message below be displayed and you will be asked to type again.

  ```ruby
  # >> Cannot convert `x` into 'float' type
  ```
  You won't need to type the box weight as the app will automatically calculate for you.
  Once you added a new product will will be able to see in View my stock list 

## 2. View my stock list

This option displays a list of all the products you have.

|Item Id|Product | Category | Quantity| Qty per box| Item Weight| Box weight|
|----|---|---|---|---|---|---|
|1|pd name| toys| 25| 5| 0.5kgs | 2.5kg|
|2|pd name2| souvenir | 250 | 25 | 0.1kg| 2.5kg|

## 3. Manage my sotck

 You can edit or delete product in this option.

1. Edit Product

To edit product, choose the product by its name then click enter, then a confirmation menu will be displayed.
Once you edited, the item will be displayed at the bottom of the list and a confirmation box will be displayed.<br>

2. Delete product

This menu deletes the product and all items related to it, you will choose the item by its name, once deleted a confirmation box will be displayed.

3. Back to main menu

Returns to main menu

## In and Out

In this menu you can add quantity or remove quantity in your stock for each item.

Choose an option
1. In

Select this option if you want to add quantity for a singular product

2. Out

Select this option if you want to remove quantity for a singular product


3. Back to main menu

Returns to main menu

## Outline of User Interaction

- The user can learn about how to intercat with the app using `help` options
- To avoid any crash in the aplication all the options and user's inputs are done via gem tty-prompt.

## Project Management

I used Trello to manage the different tasks that needed to be done.

Here is a link to [my board](https://trello.com/b/pcOipxcX/warehouse-stock-app).

## Diagram

Here is a link to [Flowchart](https://drive.google.com/file/d/1as8V9XLaxx0Vfd5kc77o233gk7dYuD-K/view?usp=sharing).

## Tests

Here is a link to my [testing spreadsheet](https://drive.google.com/file/d/1O69_4NuKMkQXaCRHSrXhHRSqYERMocMO/view?usp=sharing).

