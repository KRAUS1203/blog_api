class User
    include Mongoid::Document
    include ActiveModel::SecurePassword
    field :name, type: String
    field :email, type: String
    field :auth_token, type: String
    field :password_digest

    has_many :posts
    # data validations
    validates :name, :email, :presence => true
    validates :email, :uniqueness => true
    
    # password encryption
    has_secure_password

    # generating auth token on new login
    def generate_auth_token
        self.auth_token = SecureRandom.urlsafe_base64
        generate_auth_token if User.where(auth_token: self.auth_token).present?
    end
end