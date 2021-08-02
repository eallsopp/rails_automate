# conroller gets data, then saves data in model, which the controller can then generate a view

class Sessions < ActiveRecord::Base
  # skip_before_action :login_required, :only => [:new, :create]

  def valid_login

    if User.logged_in?
      redirect '/timesheet/:username'
    else 
      flash[:message] = 'Username or password incorrect.  Please try again.'
      redirect_to login_path
    end
  end

  def test_session?

  end

  def create
    session[:current_user_id] = @user.id
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