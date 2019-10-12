class AccessControlsController < ApplicationController
  before_action :auth_user, only: [:index, :show]
  before_action :auth_admin, only: [:index, :show, :new, :create,
                                   :edit, :update, :destroy]

  def index
    @access_controls = AccessControl.all.paginate(page: params[:page])
    @access_controls_view = AccessControl.all
  end

  def show
  end

  def new
    @access_control = AccessControl.new
  end

  def create
    @access_control = AccessControl.new(access_control_params)
    if @access_control.save
      flash[:info] = "Successfully added Prox Badge"
      redirect_to access_controls_path
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    AccessControl.find(params[:id]).destroy
    flash[:success] = "Prox Badge deleted"
    redirect_to access_controls_path
  end

  private

  def access_control_params
    params.require(:access_control).permit(:user_first_name, :user_last_name,
                                           :key_code, :access_level)
  end

  #confirms a logged in user.
  def auth_user
    if !current_user
      redirect_to root_url
    end
  end

  # Confirms an admin user.
  def auth_admin
    if !current_user.admin
      redirect_back
    end
  end
end
