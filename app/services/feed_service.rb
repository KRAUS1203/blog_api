class FeedService
  class << self
    def rate_me(post)
      share_weight = 5
      like_weight = 2
      comment_weight = 1
      view_weight  = 0.2
      decay = 0.5
      time =Time.now
      time_diff = (time - post.created_at).days
      total_decay = 0.5**time_diff
      score = (2*post.like_count + 1*post.comments.count+ 0.2*post.view_count)*total_decay
      post.score = score
      post.update_attributes
    end
  end
end