require 'spec_helper'

describe Question do

  it "should be a Question instance" do
    question = Question.new
    question.should be_a(Question)
  end

  describe :associations do
    it { should have_many(:comments) }
  end
  
  describe :scopes do
    it "should have a default scope created at desc" do
      question1 = Question.create :text => 'question 1', :created_at => 1.day.ago
      question2 = Question.create :text => 'question 2', :created_at => 1.hour.ago
      
      questions = Question.all
      
      questions.should == [question2, question1]
    end
  end
  
  describe :validations do
    it { should validate_presence_of(:text) }
    
    it "should validate answer presence only for persisted" do
      question = Question.new :text => 'text'
      question.should be_valid
      question.save
      
      question.should_not be_valid
      question.errors.count.should == 1
      question.errors[:answer].should_not be_empty
    
      question.answer = 'answer'
      question.should be_valid
    end
  end
  
  describe :answer do
    it "should provide answered? flag" do
      question = Question.new :text => 'text'
      question.answered?.should == false
      
      question.answer = 'answer'
      question.answered?.should == true
    end
    
    it { should_not allow_mass_assignment_of(:answer) }
  end
  
  describe :comments do
    it "should provide commentable? flag if have answered" do
      question = Question.new :text => 'text'
      question.commentable?.should == false
      
      question.answer = 'answer'
      question.answered?.should == true
      question.commentable?.should == true
    end
  end
  
end
