class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :messageText
      t.text :imageData

      t.timestamps
    end
  end
end
