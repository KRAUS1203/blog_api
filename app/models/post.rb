class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :set_arrays

  field :text, type: String
  field :like_count, type: Integer, default: 0
  field :view_count, type: Integer, default: 0
  field :score, type: Integer, default: 6
  # assumption for socre: fresh post is equal to post with 1 share + 2 likes + 3 comments + 5 views + 1 day old

  field :likes
  field :views
  belongs_to :user
  has_many :comments

  private
  def set_arrays
    if views.nil?
      self.views = []
    end

    if likes.nil?
      self.likes = []
    end
  end
end