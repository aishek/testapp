require 'spec_helper'
require 'comments_controller_helper'

describe CommentsController do
  include CommentsControllerHelper

  before do
    init_commentable_question
  end

  context :index do
    before do
      @comment1 = @question.comments.create! :text => '1', :created_at => 1.day.ago
      @comment2 = @question.comments.create! :text => '1', :created_at => 1.hour.ago
      @comment3 = @question.comments.create! :text => '1', :created_at => 1.minute.ago
      get :index, :question_id => @question.id
    end
    
    it "should assigns to @comments all comments of question" do
      should_comments_be_ok
    end
    
    it "should assigns to @comment new question's comment" do
      should_comment_be_ok
    end
    
    it { should assign_to(:comment) }
    it { should assign_to(:comments) }
    it { should assign_to(:question) }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  context :create do
    context :with_valid_params do
      
      it "creates a new comment" do
        expect {
          post :create, :question_id => @question.id, :comment => { :text => 'text' }
        }.to change(@question.comments, :count).by(1)
      end
      
      context :common do
        before do
          post :create, :question_id => @question.id, :comment => { :text => 'text' }
        end
  
        it "should assigns to @comments all comments of question" do
          should_comments_be_ok
        end
  
        it { should assign_to(:comment) }
        it { should assign_to(:comments) }
        it { should assign_to(:question) }
        it { should respond_with(:redirect) }
        it { should redirect_to(question_comments_url(@question)) }
      end
      
    end
  
    context :with_invalid_params do
      before do
        post :create, :question_id => @question.id, :comment => { :text => '' }
      end
    
      it "should assigns to @comments all comments of question" do
        should_comments_be_ok
      end
    
      it "should assigns to @comment new question's comment" do
        should_comment_be_ok
      end
    
      it { should assign_to(:comment) }
      it { should assign_to(:comments) }
      it { should assign_to(:question) }
      it { should respond_with(:success) }
      it { should render_template(:index) }
      
    end
  end

end
