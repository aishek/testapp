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

  describe :scopes do
    it "should have a default scope created at desc" do
      question = Question.create! :text => 'text'
      question.answer = 'answer'
      question.save!

      comment1 = Comment.create! :text => '1', :question_id => question.id, :created_at => 1.day.ago
      comment2 = Comment.create! :text => '2', :question_id => question.id, :created_at => 1.hour.ago
      
      question.comments.should == [comment2, comment1]
    end
  end
   
  describe :validations do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:text) }
    it "commentable question" do
      question = Question.create! :text => 'a'
      comment = question.comments.build :text => 'b'

      comment.should_not be_valid
      comment.errors.count == 1
      comment.errors[:question].should_not be_empty
      
      question.answer = 'answer'
      question.save!

      comment.should be_valid
    end
  end
   
end
