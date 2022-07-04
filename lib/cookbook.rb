require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path = nil)
    @csv_file_path = csv_file_path
    @recipes = []
    unless csv_file_path.nil?
      CSV.foreach(csv_file_path) do |row|
        @recipes << Recipe.new(row[0], row[1], row[2], row[3])
      end
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def mark_recipe_as_done(recipe_index)
    @recipes[recipe_index].mark_as_done
    update_csv
  end
  private

  def update_csv
    unless @csv_file_path.nil?
      CSV.open(@csv_file_path, "wb") do |csv|
        @recipes.each do |recipe|
          csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time]
        end
      end
    end
  end
end
