# get data from models User.whatever


class ApplicationController < ActionController::Base
  #prevent CSRF attacks by raising exception
  #for apis, using :null_session instead
  protect_from_forgery with: :exception
  # skip_before_action :login_required

  layout '/header', only: [:index, :sample, :login]
  

  def login_required
    if !logged_in?
      redirect_to login_path :notice => 'Log in to edit or delete content.'
    end
  end

  def logged_in?
    !!current_user
  end

  helper_method :logged_in?
  
  #get details about our current user
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      @current_user
    else
      false
    end
  end

  helper_method :current_user

  def register
    render 'application/register'
  end

  def index
    response = {  body:'in the visitor page',
                  content_type: 'text/html',
                  status: 200
    }

    render 'application/index'
  end

  def sample
    @user = 'my friend'
    @chart = sample_chart

    #number of minutes
    @sample_minutes = @chart.map { |hash| hash[:data].values.map(&:to_i).inject(:+) }.flatten
    
    #number of entries
    @sample_entries = @chart[0][:data].size
    
    #collected value of minutes for logged entries
    @total_minutes_logged = @chart.map {|hash| hash[:data].values.map(&:to_i).inject(:+)}.inject(:+)

    @minutes_per_day =  @sample_minutes.inject(:+) / @sample_entries
    @average_hours_used = minutes_to_hours(@minutes_per_day)
    @average_minutes_remaining = (24*60) - @minutes_per_day
    @hours_remaining = minutes_to_hours(@average_minutes_remaining)
    
    chart_names = @chart.map {|hash| hash[:name]}
    chart_values = @sample_minutes

    @daily_activity_hours = sample_chart.map do |hash|
      [hash[:name], ((hash[:data].values.map(&:to_i).inject(:+) / @sample_entries).round(2).to_f/60.round(2))]
    end

    render 'application/sample'
  end

  def reset_password
    redirect_to login_path, notice: "A password change of request email has been sent."
  end

  def edit_post  
    if logged_in?
      @date = get_date_by_id(params['id'])
      @entries = find_entry_by_id(params['id'])
      render 'application/edit_post/:id/:date'
    else 
      flash[:message] = 'Sorry, you cannot edit the sample page.'
      redirect_to sample_path
    end
  end

  def new_entry
    render 'application/new_entry'
  end

  #create?/new?
  def create_entry

    entry = Entry.new('activity_name' => params['activity_name'],
                      'minutes_used'  => params['minutes_used'],
                      'date'          => params['date'])

    entry.save
    redirect '/timesheet'
  end

  def update_entry
    #params['user_id'] would be the session held in a cookie/session
    #this alos needs to be an extraction of data that iterates
    #to update the db

    #post = Post.find(params['id']) <- from session

    update_query = <<-SQL
      UPDATE entries
      SET activity_name = ?,
          minutes_used  = ?,
      WHERE    user_id = ?,
      AND      'date'     = ?
    SQL
    
    #what dataset does the form return as?  array? hash?

    # @updated_values.each do |new_entry|
      # connection.execute update_query, new_entry[params['activity_name']], new_entry[params['minutes_used']], new_entry[params['user_id']], new_entry[params['date']]
    # end

    flash[:success] = 'Updated timesheet for _DATE_'
    redirect_to '/timesheet'
  end

  def destroy
    redirect_to '/timesheet'
  end
 
  # the class method will change when sessions are enabled to defer to the @session_id as the user_id
  def self.find(id)
    entry_hash = connection.execute('SELECT * FROM entries WHERE entries.user_id = ? '), id, get_date_by_id(id)
   
  end







  private
  def sample_chart
    [ { name: 'Work', data: {'2020-12-16': '500', '2020-12-17': '480', '2020-11-29': "200"}},
      { name: 'Sleep', data: {'2020-12-16': '420', '2020-12-17': '450', '2020-11-29': "480"}},
      { name: 'Eating Meals', data: {'2020-12-16': '75', '2020-12-17': '55', '2020-11-29': "70"}},
      { name: 'Commute To', data: {'2020-12-16': '10', '2020-12-17': '9', '2020-11-29': "8"}},
      { name: 'Commute From', data: {'2020-12-16': '10', '2020-12-17': '12', '2020-11-29': "14"}},
      { name: 'Guitar', data: {'2020-12-16': '60', '2020-12-17': '60', '2020-11-29': "60"}},
      { name: 'Video Games', data: {'2020-12-16': '60', '2020-12-17': '90', '2020-11-29': "30"}},
      { name: 'Side Hustle', data: {'2020-12-16': '75', '2020-12-17': '60', '2020-11-29': "90"}},
      { name: 'Making Meals', data: {'2020-12-16': '60', '2020-12-17': '50', '2020-11-29': "45"}}
    ]
  end

  def test_values(responsibilities)
    responsibilities.keep_if { |_,v| v != '' && v.to_i >= 0}
  end

  def total_minutes(days)
    days*24*60
  end

  def minutes_to_hours(minutes)
    (minutes.to_f / 60.00).round(2)
  end

  def minutes_used(session_id)
    return 0 unless user_has_entry?(session_id)
    total_logged_minutes(session_id) / days_logged(session_id)
  end

  def average_minutes_remaining(session_id)
    return total_minutes(1) unless user_has_entry?(session_id)
    (total_minutes(days_logged(session_id)) - total_logged_minutes(session_id)) / days_logged(session_id)
  end

  def sample_pie_chart(arr1, arr2)
    donut = Hash.new
    arr1.each_with_index { |entry, idx|
      donut[entry] = arr2[idx]
    }
    donut
  end

  def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end

  def find_entry_by_id(id)
    connection.execute('SELECT * FROM entries WHERE entries.user_id = ?', id);
  end

  def get_date_by_id(id)
    connection.execute('SELECT date FROM entries WHERE entries.user_id = ?', id)[0][0];
  end
end
