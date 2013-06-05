class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :common_name
      t.string :have_want
      t.string :latin_name
      t.text :note
      t.string :plant_photo
      t.string :plant_type
      t.string :source
      t.belongs_to :user

      t.timestamps
    end
    add_index :plants, :user_id
  end
end
