class Question < ActiveRecord::Base
  default_scope order('createad_at DESC')
  
  validate :text, :precence => true
end
