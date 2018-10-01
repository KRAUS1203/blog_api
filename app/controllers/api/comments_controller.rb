class Api::CommentsController < ApplicationController
	include Authenticable
	before_action :authenticate_user

	def index
		commentable = Post.find(params[:id])
		# comments = commentable.comments
		comments = Comment.where(commentable: commentable)
		render json: comments
		# render json: Comment.all
	end
	def create
		if params[:comment_id]
			commentable = Comment.find(params[:comment_id])
		else
			commentable = Post.find(params[:post_id])
		end
		comment = Comment.create(commentable: commentable, text: params[:text], user_id: current_user.id)
		if comment.save
			render json: comment
		else
			render json: {errors: comment.errors}, status: 400
		end
	end

	private
	def comment_params
		params.permit(:text)
	end
end