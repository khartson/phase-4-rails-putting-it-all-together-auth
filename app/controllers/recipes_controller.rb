class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  before_action :authorize

  def index
    render json: Recipe.all
  end 

  def create
    recipe = User.find_by(id: session[:user_id]).recipes.create!(recipe_params)
    render json: recipe, status: :created
  end
    

  private 
  
  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end 
  def recipe_params
    params.permit(:title, :minutes_to_complete, :instructions)
  end 

  def authorize
    return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end 

end
