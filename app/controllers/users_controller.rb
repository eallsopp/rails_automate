# decison making for models and rendering in views is controller
# handles decisions and functions, rendering/response
class UsersController < ActionController::Base
  
  def change 
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.timestamps
    end
  end

  def new
    @user = User.new
  end

  # POST /users
  # POST /useres.json
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'You signed up successfully'
      flash[:color] = 'valid'
      render 'login'
    else
      flash[:notice] = 'Invalid form.  Please try again'
      flash[:color] = 'invalid'
    end
    render 'new'
  end

  def list
    @users = Users.all
  end


  def index
    current_user = User.find_by_id(session[:current_user_id])

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