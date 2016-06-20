class CreateQuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :poll_id, null: false
      t.timestamps null: false
    end
    add_index :questions, :poll_id
  end
end
