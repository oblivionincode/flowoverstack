class CommentsController < ApplicationController

  def create
    @comment = @commentable.comments.new(comments_params)
    @comment =
  end
end
