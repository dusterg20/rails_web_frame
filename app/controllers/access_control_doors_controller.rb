class AccessControlDoorsController < ApplicationController
  before_action :auth_user, only: [:index, :show]
  before_action :auth_admin, only: [:index, :show, :new, :create,
                                   :edit, :update, :destroy]

  def index
    @access_control_doors = AccessControlDoor.all
  end

  def show
    @door = AccessControlDoor.find(params[:id])
  end

  def new
    @access_control_door = AccessControlDoor.new
  end

  def create
    @access_control_door = AccessControlDoor.new(access_control_door_params)
    if @access_control_door.save
      flash[:info] = "Successfully added Prox Badge"
      redirect_to access_control_doors_path
    else
      render 'new'
    end
  end

  def edit
    @door = AccessControlDoor.find(params[:id])
  end

  def update
    @door = AccessControlDoor.find(params[:id])
    if @door.update_attributes(access_control_door_params)
      flash[:success] = "Door updated"
      redirect_to access_control_door_path
    else
      render 'edit'
    end
  end

  def destroy
    AccessControlDoor.find(params[:id]).destroy
    flash[:success] = "Prox Badge deleted"
    redirect_to access_control_doors_path
  end

  private

  def access_control_door_params
    params.require(:access_control_door).permit(:name, :location, :description,
                                           :reader_manuf, :reader_model,
                                           :reader_serial)
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
