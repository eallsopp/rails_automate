#each person registered

class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password, :confirm_password

 

  def self.new(attributes={})
    
  end
  #A user will have many activities
  # has_many :activities

  #a user will have many entries
  # has_many :entries

  
end