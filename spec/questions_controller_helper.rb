module QuestionsControllerHelper
  
  def valid_attributes
    { :text => 'text' }
  end

  def init_question_and_answer
    @question = Question.create! valid_attributes
    @answer = 'answer'
  end
  
end