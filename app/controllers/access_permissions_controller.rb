class AccessPermissionsController < ApplicationController
  before_action :auth_user, only: [:index, :show]
  before_action :auth_admin, only: [:index, :show, :new, :create,
                                   :edit, :update, :destroy]

  def index
    @access_permissions = AccessPermission.all
  end

  def show
    @access_permission = AccessPermission.find(params[:id])
  end

  def new
    @access_permission = AccessPermission.new
    @access_control = AccessControl.find(params[:access_control])
    @access_control_door_select = access_control_door_wrap
    @midnight = Time.parse('00:00')
    @end_of_day = Time.parse('23:59')
  end

  def create
    @access_permission = AccessPermission.create(access_permission_params)
    if @access_permission.save
      flash[:info] = "Successfully added Access Permission"
      redirect_to access_permissions_path
    else
      render 'new'
    end
  end

  def edit
    @access_permission = AccessPermission.find(params[:id])
  end

  def update
    @access_permission = AccessPermission.find(params[:id])
    if @access_permission.update_attributes(access_permission_params)
      flash[:success] = "Access Permission updated"
      redirect_to access_permission_path
    else
      render 'edit'
    end
  end

  def destroy
    AccessPermission.find(params[:id]).destroy
    flash[:success] = "Access Permission deleted"
    redirect_to access_permissions_path
  end

  private

  def access_permission_params
    params.require(:access_permission).permit(
      :access_control_id,
      :access_control_door_id,
      :sunday,
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday,
      :sunday_end,
      :monday_end,
      :tuesday_end,
      :wednesday_end,
      :thursday_end,
      :friday_end,
      :saturday_end
    )
  end

  def access_control_door_wrap
    if !@access_control
      AccessControlDoor.all.collect do |door|
        [door.name, door.id]
      end
    else
      [[@access_control.user_first_name, @access_control.id]]
    end
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
