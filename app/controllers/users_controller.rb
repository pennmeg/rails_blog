class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
    puts "**** home ****"
  end

  def login_form
    puts "**** login_form ****"
  end

  def login
    puts "\n******* login *******"
    # puts "params: #{params.inspect}" # unapproved params
    ok_params = login_params
    @user = User.where(username: ok_params[:username]).first
    puts "@user: #{@user.inspect}"
    if @user
      if @user.password == ok_params[:password]
        session[:user_id] = @user[:id]
        puts "session[:user_id]: #{session[:user_id].inspect}"
        current_user
        redirect_to :home
      else
        redirect_to "/login_form", notice: 'Your password was incorrect.  Please try again'
      end
    else
       redirect_to "/login_form", notice: 'Your username was incorrect.  Please try again'
    end
  end

  def logout
    puts "**** logout ****"
    session[:user_id] = nil
    redirect_to :home, notice: "See you for your next vacation!"
  end

  # GET /users /users.json
  def index
    puts "**** index ****"
    @users = User.all
  end

  # GET /users/1   # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to home_path(@user), notice: 'New user profile was successfully created. Please log in.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def login_params
      puts "******* login_params *******"
      params.permit(:username, :password)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      puts "**** user_params ****"
      params.require(:user).permit(:firstname, :lastname, :email, :username, :password)
      # params.fetch(:user, {})
    end
end
