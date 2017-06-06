class UsersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :full_name]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def ushow
    @user = User.find_by_id(params[:format])
  end

  def uedit
    @user = User.find_by_id(params[:format])
  end

  def update
    respond_to do |format|
      if @user.update(cleaner_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :ushow, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def udestroy
    @user = User.find_by_id(params[:format])
    if @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    else
      render :index
    end
  end

  def suspend
    @user = User.find_by_id(params[:format])
    if @user.update(suspend: true)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :index
    end
  end

  def active
    @user = User.find_by_id(params[:format])

    if @user.update(suspend: false)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :suspend )
    end
end
