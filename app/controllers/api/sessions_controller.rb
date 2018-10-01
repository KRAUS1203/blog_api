class Api::SessionsController < ApplicationController
    def create
        user_password = params[:password]
        user_email = params[:email]
        if (user = User.find_by(email: user_email).try(:authenticate, user_password))
          # check if temp pswd, do not create auth token
          # create auth token in case of token expiry and permanent pswd
          if !user.auth_token
            user.generate_auth_token
            user.save
          end
          render json: user, adapter: :json
        else
          render json: {errors: 'Invalid Email and password'}, status: 401
        end
    end

    def destroy
        user = User.find_by(auth_token: request.headers['Authorization']) if request.headers['Authorization'].present?
        if user
          user.auth_token = nil
          user.save
          render json: {message: "Successfully logged out!!"}, status: 200
        else
          render json: {errors: "Invalid Authorization. Please try again."}, status: 400
        end
    end
end