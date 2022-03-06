class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.search(params[:search]).latest
    @user = current_user

  end

  def show
    @user = current_user

    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: @question.id)

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
      redirect_to questions_url, notice: 'Question was successfully destroyed.'
    end


  private

  def set_question
    if params[:tag]
      @question = Question.tagged_with(params[:tag])
    else
    @question = Question.find(params[:id])
    end
  end

  def question_params
    params.require(:question).permit(:title, :content, :tag_list)
  end
end
