require 'spec_helper'
require 'questions_controller_helper'

describe QuestionsController do
  include QuestionsControllerHelper

  context :index do
    before do
      @question = Question.create! valid_attributes
      get :index
    end
    
    it "should assigns all Questions via @questions" do      
      assigns(:questions).should == [@question]
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  context :new do
    before do
      get :new
    end
    
    it { should assign_to(:question) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  context :create do
    context :with_valid_params do
      
      it "creates a new Question" do
        expect {
          post :create, :question => valid_attributes
        }.to change(Question, :count).by(1)
      end
      
      context :common do
        before do
          post :create, :question => valid_attributes
        end

        it { should assign_to(:question) }
        it { should respond_with(:redirect) }
        it { should redirect_to(root_url) }
      end
      
    end

    context :with_invalid_params do
      it "assigns a newly created but unsaved Question as @question" do
        post :create, :question => {}
        assigns(:question).should be_a_new(Question)
      end
      
      context :common do
        before do
          post :create, :question => {}
        end

        it { should assign_to(:question) }
        it { should respond_with(:success) }
        it { should render_template(:new) }
      end

    end
  end

  context :answer do
    before do
      question = Question.create! valid_attributes
      get :answer, :id => question.id
    end

    it { should assign_to(:question) }
    it { should respond_with(:success) }
    it { should render_template(:answer) }
  end
  
  context :save_answer do
    context :with_valid_params do
      it "answer to Question" do
        init_question_and_answer
        expect {
          post :save_answer, :id => @question.id, :question => { :answer => @answer }
          @question.reload
        }.to change(@question, :answer).to(@answer)
      end
      
      context :common do
        before do
          init_question_and_answer
          post :save_answer, :id => @question.id, :question => { :answer => @answer }
        end
        
        it { should assign_to(:question) }
        it { should respond_with(:redirect) }
        it { should redirect_to(root_url) }
      end      
    end

    context :with_invalid_params do
      it "assigns target but unsaved Question as @question" do
        question = Question.create! valid_attributes
        post :save_answer, :id => question.id, :question => { :answer => '' }
        assigns(:question).should be_a(Question)
        assigns(:question).should be_invalid
      end
      
      context :common do
        before do
          question = Question.create! valid_attributes
          post :save_answer, :id => question.id, :question => { :answer => '' }
        end
        
        it { should assign_to(:question) }
        it { should respond_with(:success) }
        it { should render_template(:answer) }        
      end
      
    end
  end

end
