class Question < ActiveRecord::Base
  default_scope order('created_at DESC')
  
  validate :text, :precence => true
end
