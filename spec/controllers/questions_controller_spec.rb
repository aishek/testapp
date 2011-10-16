require 'spec_helper'

describe QuestionsController do

  describe :index do
    pending "should assigns all Questions via @questions"
  end

  describe :new do
    pending "should assigns new Question via @question"
  end

  describe :create do
    describe :with_valid_params do
      pending "creates a new Question"
      pending "assigns a newly created Question as @question"
      pending "redirects to the root"
    end

    describe :with_invalid_params do
      pending "assigns a newly created but unsaved Question as @question"
      pending "re-renders the 'new' template"
    end
  end

  describe :answer do
    pending "should assigns new Question via @question"
  end
  
  describe :save_answer do
    describe :with_valid_params do
      pending "answer to Question"
      pending "assigns an answered Question as @question"
      pending "redirects to the root"
    end

    describe :with_invalid_params do
      pending "assigns target but unsaved Question as @question"
      pending "re-renders the 'answer' template"
    end
  end

end
