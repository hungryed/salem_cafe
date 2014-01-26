# SECTION CREATION
Seeders::Sections.seed
grill = Section.where(name: 'Grill').first
breakfast = Section.where(name: 'Breakfast').first
deli = Section.where(name: 'Deli').first
hot_line = Section.where(name: 'Hot Line').first



# CATEGORY CREATION
grill_entree = Seeders::FoodCategories.make(grill, 'Entree', 'Main Course')
grill_side = Seeders::FoodCategories.make(grill, 'Side', 'Small item')
grill_topping = Seeders::FoodCategories.make(grill, 'Topping', 'Topping')
grill_sauce = Seeders::FoodCategories.make(grill, 'Sauce')

breakfast_entree = Seeders::FoodCategories.make(breakfast, 'Entree', 'Main Course')
breakfast_side = Seeders::FoodCategories.make(breakfast, 'Side', 'Small item')
breakfast_topping = Seeders::FoodCategories.make(breakfast, 'Topping', 'Topping')

deli_special_sandwich = Seeders::FoodCategories.make(deli, 'Special Sandwich', 'Main Course')
deli_side = Seeders::FoodCategories.make(deli, 'Side', 'Small Item')
deli_topping = Seeders::FoodCategories.make(deli, 'Topping', 'Topping')
deli_sauce = Seeders::FoodCategories.make(deli, 'Sauce')

hot_line_side = Seeders::FoodCategories.make(hot_line, 'Side', 'Small Item')
hot_line_entree = Seeders::FoodCategories.make(hot_line, 'Entree', 'Main Course')

# Breakfast FOOD
Seeders::Foods.make(breakfast_entree, 'Bacon Egg and Cheese','On any type of bread')
Seeders::Foods.make(breakfast_entree, 'Sausage Egg and Cheese','On any type of bread')
Seeders::Foods.make(breakfast_entree, 'Omelette','Fill with tasty toppings')
Seeders::Foods.make(breakfast_entree, 'Spanish Omelette','Fill with tasty toppings')
Seeders::Foods.make(breakfast_side, 'Boiled Egg')
Seeders::Foods.make(breakfast_side, 'Bacon')
Seeders::Foods.make(breakfast_side, 'Sausage')
Seeders::Foods.make(breakfast_topping, 'Spinach')
Seeders::Foods.make(breakfast_topping, 'Olives')
Seeders::Foods.make(breakfast_topping, 'Bacon Bits')
Seeders::Foods.make(breakfast_topping, 'Onions')
Seeders::Foods.make(breakfast_topping, 'Diced Tomatoes')

# GRILL FOOD
Seeders::Foods.make(grill_entree, 'Reuben Sandwich')
Seeders::Foods.make(grill_entree, 'French Dip Sandwich')
Seeders::Foods.make(grill_entree, 'Fried Fish')
Seeders::Foods.make(grill_entree, 'Hot Dog')
Seeders::Foods.make(grill_entree, 'Cheeseburger')
Seeders::Foods.make(grill_entree, 'Hamburger')
Seeders::Foods.make(grill_side, 'French Fries')
Seeders::Foods.make(grill_side, 'Onion Rings')
Seeders::Foods.make(grill_side, 'Tater Tots')
Seeders::Foods.make(grill_topping, 'Lettuce')
Seeders::Foods.make(grill_topping, 'Tomatoe')
Seeders::Foods.make(grill_topping, 'Onion')
Seeders::Foods.make(grill_topping, 'Chili')

# DELI FOOD
Seeders::Foods.make(deli_special_sandwich, 'Turkey and Bacon Sub')
Seeders::Foods.make(deli_special_sandwich, 'Cold Cut Sandwich')
Seeders::Foods.make(deli_special_sandwich, 'Pimento Cheese Sandwich')
Seeders::Foods.make(deli_special_sandwich, 'Sicilian Combo')
Seeders::Foods.make(deli_topping, 'Lettuce')
Seeders::Foods.make(deli_topping, 'Tomatoe')
Seeders::Foods.make(deli_topping, 'Onion')
Seeders::Foods.make(deli_side, 'Pasta Salad')
Seeders::Foods.make(deli_side, 'Three-bean Pasta')
Seeders::Foods.make(deli_sauce, 'Ranch')
Seeders::Foods.make(deli_sauce, 'Southwest')
Seeders::Foods.make(deli_sauce, 'Mayonaisse')

#HOT LINE FOOD
Seeders::Foods.make(hot_line_entree, 'Chicken Brocolli Cheedar Bake')
Seeders::Foods.make(hot_line_entree, 'Carved Roast Beef')
Seeders::Foods.make(hot_line_entree, 'Roast Pork Loin')
Seeders::Foods.make(hot_line_entree, 'Chicken Pot Pie')
Seeders::Foods.make(hot_line_entree, 'Seafood Basket')
Seeders::Foods.make(hot_line_side, 'Corn')
Seeders::Foods.make(hot_line_side, 'Corn Fritters')
Seeders::Foods.make(hot_line_side, 'Hush Puppies')
Seeders::Foods.make(hot_line_side, 'Collard Greens')
Seeders::Foods.make(hot_line_side, 'Baked Beans')
