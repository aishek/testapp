class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :question_id
      t.text :text

      t.timestamps
    end
    
    # index for comments output for specific question
    #   column 'created_at' created automatically and has datetime type
    #   in some databases index for datetime column is slow for update
    add_index :comments, [:question_id, :created_at]
  end
end
