class QuestionsController < ApplicationController
  before_filter :find_question_by_id, :only => [:answer, :save_answer]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new params[:question]
    if @question.save
      redirect_to root_url, notice: "Question asked"
    else
      render action: "new"
    end
  end

  def answer
  end

  def save_answer    
    @question.answer = params[:question][:answer]

    if @question.save
      redirect_to root_url, notice: "Question answered."
    else
      render action: "answer"
    end
  end


  private
  
  def find_question_by_id
    @question = Question.find params[:id]
  end

end
