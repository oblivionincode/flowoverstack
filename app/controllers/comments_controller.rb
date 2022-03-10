class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :correct_user, only: [:edit, :update, :destroy]


  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id


    if @comment.save
      redirect_to @commentable, notice: "Comment created"
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted"
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  private

  def correct_user
    @comment = Comment.find(params[:id])
    redirect_to @commentable, notice: 'Unauthorized action' unless current_user?(@comment.user)
  end


  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    if params[:question_id].present?
      @commentable = Question.find_by_id(params[:question_id])
    else params[:answer_id].present?
      @commentable = Answer.find_by_id(params[:answer_id])


    end
  end
end

