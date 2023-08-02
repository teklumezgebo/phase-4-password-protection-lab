class UsersController < ApplicationController
skip_before_action :authorized, only: :create
rescue_from ActiveRecord::RecordInvalid, with: :invalid_user
  
    def show 
        user = User.find(session[:user_id])
        render json: user
    end

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :unprocessable_entity
    end

    private

    def user_params
        params.permit(:username, :password)
    end

    def invalid_user(invalid)
        render json: { error: invalid.record.errors }, status: :unprocessable_entity
    end

end
