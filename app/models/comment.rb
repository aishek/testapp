class Comment < ActiveRecord::Base
  belongs_to :question, :inverse_of => :comments
  
  validates :question, :text, :presence => true
end
