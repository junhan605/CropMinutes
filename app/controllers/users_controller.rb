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

  def uupdate
    @user = User.find_by_id(params[:format])
    user = params[:user]
    @user.name = user[:name]
    @user.first_name = user[:first_name]
    @user.last_name = user[:last_name]
    @user.email = user[:email]
    if user[:password] != nil
      @user.password = user[:password]
      @user.password_confirmation = user[:password_confirmation]
    end

    @user.companies = user[:company_ids].present? ? Company.where(id: user[:company_ids]) : [ ]

    if @user.save
      redirect_to users_ushow_path(@user), notice: 'User was successfully updated.'
    else
      format.html { render :ushow }
      format.json { render json: @user.errors, status: :unprocessable_entity }
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
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :suspend, companies_ids: [])
    end
end
