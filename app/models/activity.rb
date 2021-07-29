#this is a single entry/day for a user

class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end