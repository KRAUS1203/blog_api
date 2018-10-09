class Api::PostsController < ApplicationController
    include Authenticable
    before_action :authenticate_user

    def index
        # after algorithm
        posts = Post.where().limit(10)
        render json: posts
    end

    def create
        post = current_user.posts.new(post_params)
        if post.save
            render json: post, status: 201
        else
            render json: {errors: post.errors}, status: 400
        end
    end

    def show
        post = Post.find(params[:id])
        if post
            render json: post, status: 200
        else
            if post.user_id === current_user.id
                render json: post, status: 200
            else
                render json: {errors: 'Post does not exists'}, status: 404
            end
        end
    end

    def create_like
        post = Post.find_by(_id: params[:id], likes: {'$ne': current_user.id})
        if post
            like_count = post.like_count + 1
            likes = post.likes
            likes << current_user.id
            post.update_attributes(likes: likes, like_count: like_count)
            render json: post, status: 202
        else
            render json: {error: 'no post found'}, status: 404
        end
    end

    def create_view
        post = Post.find_by(_id: params[:id], views: {'$ne': current_user.id})
        if post
            view_count = post.view_count + 1
            views = post.views
            views << current_user.id
            post.update_attributes(views: views, view_count: view_count)
            render json: post, status: 202
        else
            render json: {error: 'no post found'}, status: 404
        end
    end

    private
    def post_params
        params.permit(:text)
    end
end