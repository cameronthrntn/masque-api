class CreateMasks < ActiveRecord::Migration[6.0]
  def change
    create_table :masks do |t|
      t.string :mask
      t.string :colour
      t.references :topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
