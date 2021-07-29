#each person registered as a user

class User < ActiveRecord::Base
  has_secure_password

  def validate!
    @errors.add(:email, :blank, message: "can't be blank") if email.nil?
  end
  
  attr_accessor :email
  attr_reader :errors

  #the user shares details with the model posts, which are entries of activities/timeused
  has_many :posts

  #these activities are shared through the posts of the user
  has_many :activities, through: :posts

  #ensure new user information is obtained to prevent duplication in db
  validates :email, presence: true

  #! attempts mutation, will be blocked if it cannot go through
  def confirm!
    update!(confirmed_at: DateTime.now)
  end

  #return value is true or false
  def confirmed?
    ! confirmed_at.nil?
  end

  #in the activities model, are there any that share that name of the arg passed as parameter
  def activities?(activity)
    activities.any? { |r| r.name.underscore.to_sym == activity}
  end

  # The following methods are needed to be minimally implemented

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end
end