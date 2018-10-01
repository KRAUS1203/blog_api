class Api::CommentsController < ApplicationController
	include Authenticable
	before_action :authenticate_user

	def index
		comments = Comment.where(post_id: params[:id]).order(_id: -1)
		if comments.count > 0
			render json: comments
		else
			render json:{error: 'no comments found'}, status: 404
		end
		# render json: Comment.all
	end

	def create
		post = Post.find_by(_id: params[:id])
		if post
			comment = post.comments.new(comment_params)
			if comment.save
				render json: comment, status: 201
			else
				render json: {error: comment.errors}, status: 400
			end
		else
			render json: {error: 'no post found'}, status: 404
		end
	end

	private
	def comment_params
		params.permit(:text)
	end
end