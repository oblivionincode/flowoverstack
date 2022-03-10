class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def upvote
    @answers = Answer.find(params[:id])
    if current_user.voted_up_on? @answers
      @answers.unvote_by current_user
    else
      @answers.upvote_by current_user
    end
    redirect_back(fallback_location: root_path)

  end

  def downvote
    @answers = Answer.find(params[:id])
    if current_user.voted_down_on? @answers
      @answers.unvote_by current_user
    else
      @answers.downvote_by current_user
    end
    redirect_back(fallback_location: root_path)


  end

  def show
    @commentable = @answer
    @comment = Comment.new
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

      if @answer.save
        redirect_to @answer.question, notice: 'Answer was successfully created.'
      else
        render :new
      end
  end

  def update
      if @answer.update(answer_params)
        redirect_to @answer.question, notice: 'Answer was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @answer.destroy
      redirect_to @answer.question, notice: 'Answer was successfully destroyed.'

  end

  private


  def correct_user
    @answer = Answer.find(params[:id])
    redirect_to @answer, notice: 'Unauthorized action' unless current_user?(@answer.user)
  end


  def set_answer
    @answer = Answer.find(params[:id])
  rescue
    flash[:notice] = "ERROR"
    redirect_to root_url
  end

  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id)
  end
end
