class Question < ActiveRecord::Base
  default_scope order('created_at DESC')
  
  attr_protected :answer
  
  has_many :comments, :inverse_of => :question, :dependent => :destroy
  
  validates :text, :presence => true
  validates :answer, :presence => true, :unless => :new_record?
  
  def answered?
    answer.present?
  end
  
  def commentable?
    answered?
  end
end
