require 'spec_helper'

describe Question do

  it "should be a Question instance" do
    question = Question.new
    question.should be_a(Question)
  end

  describe :associations do
    pending "should have many comments"
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
    it "should validate text presence" do
      question = Question.new
      question.should_not be_valid
      question.errors.count.should == 1
      question.errors[:text].should_not be_empty
      
      question.text = 'text'
      question.should be_valid
    end
    
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
    
    it "should be protected from answer via mass-assigment" do
      question = Question.new :text => 'text', :answer => 'answer'
      question.answer.should == nil
    end
  end
  
end
