class SessionsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      return render json: user, status: :created
    else 
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end 
  end 

  def destroy
    if session[:user_id]
      session.delete :user_id
      head :no_content
    else 
      render json: { errors: ['You are not logged in'] }, status: :unauthorized
    end 
  end 

end
