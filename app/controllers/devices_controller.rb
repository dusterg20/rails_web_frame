# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :auth_user, only: [:index, :show]
  before_action :auth_admin, only: [:index, :show, :new, :create,
                                   :edit, :update, :destroy]

  def index
    @devices = Device.all.paginate(page: params[:page])
  end

  def show
    @device = Device.find(params[:id])
    rpi = @device.rpi_id
    @rpi = Rpi.find(rpi)
  end

  def new
    @rpis = Rpi.find(params[:rpis])
    @rpi_select = rpi_wrap
    @device = Device.new
  end

  def create
    rpi = Rpi.find(params[:device][:rpi_id])
    @device = rpi.devices.create(device_params)
    if @device.save
      flash[:info] = "Successfully added Device"
      redirect_to devices_path
    else
      render 'new'
    end
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      flash[:success] = "Device updated"
      redirect_to device_path
    else
      render edit
    end
  end

  def destroy
    Device.find(params[:id]).destroy
    flash[:success] = "Device deleted"
    redirect_to devices_path
  end

  private

  def device_params
    params.require(:device).permit(:dev_name, :pi_id, :dev_location, :dev_pin_count,
                  :dev_pin1, :dev_pin2, :dev_pin3, :dev_pin4,
                  :dev_pin5, :dev_data)
  end

  def rpi_wrap
    if !@rpis
      Rpi.all.collect do |pi|
        [pi.rpi_name, pi.id]
      end
    else
      [[@rpis.rpi_name, @rpis.id]]
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
