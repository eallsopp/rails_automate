#this is a single entry/day for a user
# Models like this handle the datapoints
# connection to DB/where store data from
# only return certain posts

class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end