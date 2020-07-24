require 'rails_helper'

RSpec.describe 'Dish show page' do
  describe "As a visitor" do
    it "Can see a list of ingredients and the chef's name" do
      jim = Chef.create(name: "Jim")
      dish1 = Dish.create(name: "Potato Salad", description: "Potato salad with mustard", chef_id: jim.id)
      dish2 = Dish.create(name: "Green Beans", description: "Green Beans with butter", chef_id: jim.id)
      potatoes = Ingredient.create(name: "potatoes", calories: 400)
      mustard = Ingredient.create(name: "mustard", calories: 50)
      green_beans = Ingredient.create(name: "green beans", calories: 100)
      butter = Ingredient.create(name: "butter", calories: 300)

      DishIngredient.create(dish: dish1, ingredient: potatoes)
      DishIngredient.create(dish: dish1, ingredient: mustard)
      DishIngredient.create(dish: dish2, ingredient: green_beans)
      DishIngredient.create(dish: dish2, ingredient: butter)

      visit "dishes/#{dish1.id}"

      expect(page).to have_content(dish1.name)
      expect(page).to have_content(dish1.chef.name)
      expect(page).to have_content(mustard.name)
      expect(page).to_not have_content(butter.name)
    end

    it "can see the total calorie count for that dish" do
      jim = Chef.create(name: "Jim")
      dish1 = Dish.create(name: "Potato Salad", description: "Potato salad with mustard", chef_id: jim.id)

      potatoes = Ingredient.create(name: "potatoes", calories: 400)
      mustard = Ingredient.create(name: "mustard", calories: 50)

      DishIngredient.create(dish: dish1, ingredient: potatoes)
      DishIngredient.create(dish: dish1, ingredient: mustard)

      visit "dishes/#{dish1.id}"

      expect(page).to have_content(450)
    end
  end
end
