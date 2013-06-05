class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :bio
      t.date :birth_date
      t.string :city
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :postal
      t.string :profile_picture
      t.string :province
      t.string :type_of_garden
      t.string :user_name

      t.timestamps
    end
  end
end
