class Api::UsersController < ApplicationController
    # include Authenticable

    # before_action :authenticate_user, only: [:create, :show, :logged_in_user]
    def index
        render json: 'hello'
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: 201
        else
            render json: {errors: @user.errors}, status: 400
        end
    end

    def logged_in_user
        render json: current_user
    end
    def show
        @user = User.find(params[:id])
        if @user
            render json: @user, status: 200
        else
            render json: {errors: 'No user found'}, status: 404
        end
    end

    def update
        current_user.update_attributes(user_params)
        render json: current_user
    end

    private
    def user_params
        params.permit(:name, :password, :email)
    end
end