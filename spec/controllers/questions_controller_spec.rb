require 'spec_helper'
require 'questions_controller_helper'

describe QuestionsController do
  include QuestionsControllerHelper

  describe :index do
    it "should assigns all Questions via @questions" do
      question = Question.create! valid_attributes
      get :index
      assigns(:questions).should == [question]
    end
  end

  describe :new do
    it "should assigns new Question via @question" do
      get :new
      assigns(:question).should be_a_new(Question)
    end
  end

  describe :create do
    describe :with_valid_params do
      it "creates a new Question" do
        expect {
          post :create, :question => valid_attributes
        }.to change(Question, :count).by(1)
      end
      
      it "assigns a newly created Question as @question" do
        post :create, :question => valid_attributes
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end
      
      it "redirects to the root" do
        post :create, :question => valid_attributes
        response.should redirect_to(root_url)
      end
    end

    describe :with_invalid_params do
      it "assigns a newly created but unsaved Question as @question" do
        Question.any_instance.stub(:save).and_return(false)
        post :create, :question => {}
        assigns(:question).should be_a_new(Question)
      end
      
      it "re-renders the 'new' template" do
        Question.any_instance.stub(:save).and_return(false)
        post :create, :question => {}
        response.should render_template("new")
      end
    end
  end

  describe :answer do
    it "should assigns new Question via @question" do
      question = Question.create! valid_attributes
      get :answer, :id => question.id
      assigns(:question).should == question
    end
  end
  
  describe :save_answer do
    describe :with_valid_params do
      it "answer to Question" do
        init_question_and_answer
        expect {
          post :save_answer, :id => @question.id, :question => { :answer => @answer }
          @question.reload
        }.to change(@question, :answer).to(@answer)
      end
      
      it "assigns an answered Question as @question" do
        init_question_and_answer
        post :save_answer, :id => @question.id, :question => { :answer => @answer }
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end
      
      it "redirects to the root" do
        init_question_and_answer
        post :save_answer, :id => @question.id, :question => { :answer => @answer }
        response.should redirect_to(root_url)        
      end
    end

    describe :with_invalid_params do
      it "assigns target but unsaved Question as @question" do
        question = Question.create! valid_attributes
        post :save_answer, :id => question.id, :question => { :answer => '' }
        assigns(:question).should be_a(Question)
        assigns(:question).should be_invalid
      end
      
      it "re-renders the 'answer' template" do
        question = Question.create! valid_attributes
        post :save_answer, :id => question.id, :question => { :answer => '' }
        response.should render_template("answer")
      end
    end
  end

end
