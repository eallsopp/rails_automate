#could be added to an entry by a user

class Post < ActiveRecord::Base
  has_many :activities
  belongs_to :users

  validates :activity_name, presence: true
end