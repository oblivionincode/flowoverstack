class StaticPagesController < ApplicationController
  def home
      @questions = Question.search(params[:search]).latest
      respond_to do |format|
        format.html # index.html.erb
      end
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
