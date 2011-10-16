module CommentHelper
  
  def valid_attributes
    @question = Question.create! :text => 'Be or not to be?'
    { :question_id => @question.id, :text => 'It\'s a good question!' }
  end
  
end