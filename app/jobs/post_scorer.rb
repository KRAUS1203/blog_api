class PostScorer
    @queue = :scoring

    def self.perform
        posts = Post.all
        if posts.count > 0
            psots.each do |post|
                FeedService.rate_me(post)
            end
        end
    end
end