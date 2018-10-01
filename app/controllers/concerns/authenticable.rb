module Authenticable

    def authenticate_user
        if current_user
            true
        else
            render json: {error: 'Not Authorized'}, status: 401
        end
    end
    def current_user
        user = User.find_by(auth_token: request.headers['Authorization']) if request.headers['Authorization'].present?
        user
    end
end