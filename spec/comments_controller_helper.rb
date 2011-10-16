module CommentsControllerHelper
  
  def init_commentable_question
    @question = Question.create! :text => 'a'
    @question.answer = 'answer'
    @question.save!
  end
  
  def should_comments_be_ok
    assigns(:comments).count.should == assigns(:question).comments.count
    assigns(:comments).each do |comment|
      comment.question.should == assigns(:question)
    end      
  end

  def should_comment_be_ok
    assigns(:comment).should be_a_new(Comment)
    assigns(:comment).question.should == assigns(:question)
  end
  
end