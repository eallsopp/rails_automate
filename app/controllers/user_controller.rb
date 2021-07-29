class UserController < ActionController::Base
  
  def new
    #how to wuickly get it registered onto the database
    #this will post to the database for the details given

  end

  def index
    @user = User.create(user_params)

    redirect_to homepage_path, notice: 'User Created Successfully'
  end

  def index
    @users = Users.all
  end

  def update
    if @user.set_attributes(params[:user])
      redirect_to user_path
    else
      render 'edit'
    end
  end


  private
  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def user_params
    params.permit(:first_name, 
                            :last_name, 
                            :email, 
                            :username, 
                            :password)
  end
end