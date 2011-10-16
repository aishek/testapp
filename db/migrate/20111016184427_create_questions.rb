class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.text :answer

      t.timestamps
    end
    
    # index for questions output
    #   column 'created_at' created automatically and has datetime type
    #   in some databases index for datetime column is slow for update
    add_index :questions, [:created_at]
  end
end
