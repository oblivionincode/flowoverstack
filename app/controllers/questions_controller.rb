# frozen_string_literal: true
class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  # GET /questions
  def index
    @questions = Question.search(params[:search])

    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @user = current_user
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: @question.id)

    @commentable = @question
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end



  def new
    @question = Question.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @question = Question.find(params[:id])
    @user = current_user
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
