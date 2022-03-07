class TagsController < ApplicationController
    @question = Question.tagged_with(params[:tag])
end
