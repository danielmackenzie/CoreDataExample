class User < ActiveRecord::Base
  has_many :plants
  attr_accessible :bio, :birth_date, :city, :email, :first_name, :last_name, :password, :postal, :profile_picture, :province, :type_of_garden, :user_name

  def as_json(options={})
    { :id => self.id,
      :bio => self.bio,
      :birth_date => self.birth_date,
      :city => self.city,
      :email => self.email,
      :first_name => self.first_name,
      :last_name => self.last_name,
      :password => self.password,
      :postal => self.postal,
      :profile_picture => self.profile_picture,
      :province => self.province,
      :type_of_garden => self.type_of_garden,
      :user_name => self.user_name,
      :plants => self.plants
    }
  end
end
