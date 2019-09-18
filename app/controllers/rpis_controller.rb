# frozen_string_literal: true

class RpisController < ApplicationController
  before_action :auth_user, only: [:index, :show]
  before_action :auth_admin, only: [:index, :show, :new, :create,
                                   :edit, :update, :destroy]

  def index
    @rpis = Rpi.all.paginate(page: params[:page])
  end

  def show
    @rpi = Rpi.find(params[:id])
  end

  def new
    @rpi = Rpi.new
  end

  def create
    @rpi = Rpi.new(rpi_params)
    if @rpi.save
      flash[:info] = "Successfully added RPI"
      redirect_to rpis_path
    else
      render 'new'
    end
  end

  def edit
    @rpi = Rpi.find(params[:id])
  end

  def update
    @rpi = Rpi.find(params[:id])
    if @rpi.update_attributes(rpi_params)
      flash[:success] = "RPI updated"
      redirect_to rpi_path
    else
      render edit
    end
  end

  def destroy
    Rpi.find(params[:id]).destroy
    flash[:success] = "RPI deleted"
    redirect_to rpis_path
  end

  private

  def rpi_params
    params.require(:rpi).permit(:rpi_name, :rpi_location, :rpi_ip, :rpi_model)
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
