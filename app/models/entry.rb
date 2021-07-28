#this is a single entry/day for a user

class Entry < ActiveRecord::Base
  #for used of form validation
  # validates_presence_of , :date, :work, :sleep, :commute_to, :commute_from, :meal_prep, :eating_meals
  attr_reader :activity_name, :minutes_used, :user_id, :date

  def initialize(attributes={})
    @activity_name = attributes['activity_name']
    @minutes_used = attributes['minutes_used']
    @commute_to = attributes['commute_to']
    @commute_from = attributes['commute_from']
    @date = attributes['date'] 
    # @user_id = attributes['user_id']#maybe unnecessary
  end

  def save 
    insert_query = <<-SQL
      INSERT INTO entries (activity_name, minutes_used, date)
      VALUES (?, ?, ?)
    SQL

    connection.execute insert_query,
      activity_name,
      minutes_used,
      date
  end

  #associated with a particular user
  belongs_to :user

  #contains many Activity models
  has_many :activities

  def connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end
end