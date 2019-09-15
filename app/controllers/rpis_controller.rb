# frozen_string_literal: true

class RpisController < ApplicationController

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
  end

  def destroy
    Rpi.find(params[:id]).destroy
    flash[:success] = "Device deleted"
  end

  private

    def rpi_params
      params.require(:rpi).permit(:rpi_name, :rpi_location, :rpi_ip)
    end
end
