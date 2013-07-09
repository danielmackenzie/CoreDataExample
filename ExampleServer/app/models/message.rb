class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :imageData, :messageText
end
