class AddHunterRefToSeller < ActiveRecord::Migration
  def change
    add_reference :sellers, :hunter, index: true, foreign_key: true
  end
end
