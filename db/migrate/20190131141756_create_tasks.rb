class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :body
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
