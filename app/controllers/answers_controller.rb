class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]


  def index
    @answers = Answer.all.order(cached_votes_score: :desc)
  end


  def upvote
    @answers = Answer.find(params[:id])
    if current_user.voted_up_on? @answers
      @answers.unvote_by current_user
    else
      @answers.upvote_by current_user
    end
    render "vote.js.erb"
  end

  def downvote
    @answers = Answer.find(params[:id])
    if current_user.voted_down_on? @answers
      @answers.unvote_by current_user
    else
      @answers.downvote_by current_user
    end
    render "vote.js.erb"
  end

  def show
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer.question, notice: 'Answer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: 'Answer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id)
  end
end
