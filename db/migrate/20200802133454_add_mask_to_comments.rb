class AddMaskToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :mask, null: false, foreign_key: true
  end
end
