#could be added to an entry by a user

class Activity < ActiveRecord::Base
  #for form additions to the space:

  #create the class instances of each for access in the templates
  attr_reader :id, :user_id


  belongs_to :entry
end