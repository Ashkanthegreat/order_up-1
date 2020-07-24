require 'rails_helper'

RSpec.describe 'Chef Show page' do
  describe "As a visitor" do
  it "Can see the name of the chef and list to all of the chefs ingredients" do

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


    visit "/chefs/#{jim.id}"

    expect(page).to have_content(jim.name)
    expect(page).to have_link("Ingredients")

    click_on "Ingredients"
    expect(current_path).to eq("/chefs/#{jim.id}/ingredients")

    expect(page).to have_content(potatoes.name)
    expect(page).to have_content(mustard.name)
    expect(page).to have_content(green_beans.name)
    expect(page).to have_content(butter.name)
  end

end

end

# Story 3 of 3
# As a visitor
# When I visit a chef's show page
# I see the name of that chef
# And I see a link to view a list of all ingredients that this chef uses in their dishes
# When I click on that link
# I'm taken to a chef's ingredient index page
# and I can see a unique list of names of all the ingredients that this chef uses
