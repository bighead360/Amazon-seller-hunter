class CreateIsbns < ActiveRecord::Migration
  def change
    create_table :isbns do |t|
      t.string :isbn

      t.timestamps null: false
    end
  end
end
