class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    if params[:tag]
      @questions = Question.tagged_with(params[:tag])
    else
    @questions = Question.search(params[:search])
    end

  end

  def show
    @user = current_user

    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: @question.id).order(cached_votes_score: :desc)


    @commentable = @question
    @comment = Comment.new
  end



  def new
    @question = Question.new
    @user = current_user

  end

  def edit
    @question = Question.find(params[:id])
    @user = current_user
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

      if @question.save
        redirect_to @question, notice: 'Question was successfully created.'
      else
        render :new
      end
    end

  def update
      if @question.update(question_params)
        redirect_to @question, notice: 'Question was successfully updated.'
      else
        render :edit
      end
    end


  def destroy
    @question.destroy
      redirect_to root_path, notice: 'Question was successfully destroyed.'
    end


  private


  def correct_user
    @question = Question.find(params[:id])
    redirect_to @question, notice: 'Unauthorized action' unless current_user?(@question.user)
  end

  def set_question
    @question = Question.find(params[:id])
  rescue
    flash[:notice] = "ERROR"
    redirect_to root_url
  end

  def question_params
    params.require(:question).permit(:title, :content, :tag_list, :search)
  end
end
