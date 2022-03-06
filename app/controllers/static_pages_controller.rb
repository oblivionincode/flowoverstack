class StaticPagesController < ApplicationController
  def home
      @questions = Question.search(params[:search]).latest
  end

  def help
  end

  def about
  end

  def contact
  end

  def faq
  end
end
