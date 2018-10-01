class Comment
    include Mongoid::Document
    include Mongoid::Timestamps::Created

    field :text, type: String
    belongs_to :user
    belongs_to :post
    # belongs_to :parent, class_name: 'Comment', optional: true
    # has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
end