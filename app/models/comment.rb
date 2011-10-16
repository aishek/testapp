require 'validators/comment/question_commentable'

class Comment < ActiveRecord::Base
  belongs_to :question, :inverse_of => :comments
  
  default_scope order('created_at DESC')
  
  validates :question, :text, :presence => true
  validates_with Validators::Comment::QuestionCommentable, :if => :question
end
