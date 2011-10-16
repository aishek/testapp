module Validators
  module Comment

    class QuestionCommentable < ActiveModel::Validator
      def validate(record)
        record.errors[:question] << 'Question is not commentable' unless record.question.commentable?
      end
    end

  end
end