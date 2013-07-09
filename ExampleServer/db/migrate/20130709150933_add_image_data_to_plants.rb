class AddImageDataToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :imageData, :text
  end
end
