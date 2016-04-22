class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.references :language, index: true
      t.string :title
      t.string :content

      t.timestamps null: false
    end
    add_foreign_key :questions, :users
    add_foreign_key :questions, :categories
    add_foreign_key :questions, :languages
  end
end
