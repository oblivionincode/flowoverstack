class CommentsController < ApplicationController
  before_action :set_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
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

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    if params[:question_id].present?
      @commentable = Question.find_by_id(params[:question_id_id])
    else params[:answer_id].present?
      @commentable = Answer.find_by_id(params[:answer_id])


    end
  end
end



class CommentsController < ApplicationController
  before_action :set_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
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

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    if params[:question_id].present?
      @commentable = Question.find_by_id(params[:question_id])
    elsif params[:answer_id].present?
      @commentable = Answer.find_by_id(params[:answer_id])
    end
  end
end


