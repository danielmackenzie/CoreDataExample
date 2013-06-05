class Plant < ActiveRecord::Base
  belongs_to :user
  attr_accessible :common_name, :have_want, :latin_name, :note, :plant_photo, :plant_type, :source
end
