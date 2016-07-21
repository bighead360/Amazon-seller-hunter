class AddHunterRefToBook < ActiveRecord::Migration
  def change
    add_reference :books, :hunter, index: true, foreign_key: true
  end
end
