class Comment < ActiveRecord::Base
  belongs_to :question, :inverse_of => :comment
  
  validates :question, :text, :presence => true
end
