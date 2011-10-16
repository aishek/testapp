require 'spec_helper'
require 'comment_helper'

describe Comment do
  include CommentHelper

  it "should be a Comment instance" do
    Comment.new.should be_a_new(Comment)
  end

  describe :associations do
    it { should belong_to(:question) }
  end
   
  describe :validations do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:text) }
  end
   
end
