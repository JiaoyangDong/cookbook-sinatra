require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "lib/cookbook"

csv_file   = File.join(__dir__, 'lib/recipes.csv')
cookbook   = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  # "<h1>Hello <em>world</em>!</h1>"
  @recipes = cookbook.all
  erb :index
end

# GET /new
get "/new" do
  erb :new
end

post '/recipes' do
  # binding.pry
  recipe = Recipe.new(params["name"], params["description"], params["rating"], params["preptime"])
  cookbook.add_recipe(recipe)
  # puts "paneer test"
  # @recipes = cookbook.all
  redirect to('/')
end

get "/delete/:index" do
  # binding.pry
  cookbook.remove_recipe(params["index"].to_i)
  puts params["index"]
  redirect back
end

get "/team/:username" do
  # binding.pry
  puts params[:username]
  "The username is #{params[:username]}"
end
