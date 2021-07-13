class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_admin, only: [:edit, :update, :index, :destroy]
  before_action :authenticate_user, only: [:show]
  before_action :authenticate_request!, only: :index
  skip_before_action :verify_authenticity_token, only: :applogin

  # def applogin
  #   user = User.find_by(email: user_params[:email].to_s.downcase)
  #   if user&.authenticate(user_params[:password])
  #     puts("authenticated")
  #     auth_token = JsonWebToken.encode(user.id, Figaro.env.jwt_secret_key, 'HS256')
  #     render json: { auth_token: auth_token }, status: :ok
  #   else
  #     puts("failed authenticatoin")
  #     render json: { error: 'Invalid username/password' }, status: :unauthorized
  #   end
  # end

  def applogin
    auth_object = Authentication.new(login_params)
    if auth_object.authenticate
      token = auth_object.generate_token
      puts("authentication success, token: " + token)
      puts render json: {
        message: "Login successful!", token: token }, status: :ok
    else
      puts "authentication failure"
      render json: {
        message: "Incorrect username/password combination"}, status: :unauthorized
    end
  end

  # def currentuser
  #   user = User.find_by(email: user_params[:email].to_s.downcase)
  #   if user&.authenticate(user_params[:password])
  #     puts("authenticated")
  #     auth_token = JsonWebToken.encode(user.id, Figaro.env.jwt_secret_key, 'HS256')
  #     render json: { auth_token: auth_token }, status: :ok
  #   else
  #     puts("failed authenticatoin")
  #     render json: { error: 'Invalid username/password' }, status: :unauthorized
  #   end
  # end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
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
    if User.all.size <1
      @user.admin = true
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :admin, :password_confirmation, :high_level_location_id)
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
end
