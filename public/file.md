# Help

|Input| Eplanation|
|--|--|
| `-l` or `--list` | will open the products list witout open the app|
| `-add` | Will open a add option to create a new product|
| `-in` | open the in and out menu|

<br>

# The aplication

### What you would like to do?

This is the main menu, you will be able to select the choice using the up or down arrows in your keyboard, then just press enter


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