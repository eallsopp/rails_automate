class Sessions < ActiveRecord::Base
  # skip_before_action :login_required, :only => [:new, :create]

  def new
   
  end

  def logged_in

    redirect 'timesheet'
  end

  def create
    
  end

  def index
    
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  private
  def login(user)
    session[:user_id] = nil
  end

  def connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end
end