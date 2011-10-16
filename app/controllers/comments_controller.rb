class CommentsController< ApplicationController

  before_filter :find_question, :assign_comments
  
  def index
    @comment = Comment.new :question_id => @question.id
  end
  
  def create
    @comment = Comment.new :question_id => @question.id, :text => params[:comment][:text]
    if @comment.save
      redirect_to question_comments_url(@question), notice: "Comment added"
    else
      render action: "index"
    end
  end
  
  
  private
  
  def assign_comments
    @comments = @question.comments
  end
  
  def find_question
    @question = Question.find params[:question_id]
  end
  
end