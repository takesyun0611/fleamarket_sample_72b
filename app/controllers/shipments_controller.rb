class ShipmentsController < ApplicationController
  def edit 
    @shipment = Shipment.find(current_user.id)
  end

  def update
    @shipment = Shipment.find(current_user.id)
    if @shipment.update(shipment_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def shipment_params
    params.require(:shipment).permit(:family_name, :given_name, :family_name_kana, :given_name_kana, :postal_code, :prefecture, :city, :house_number, :building_name, :room_number, :phone_number)
  end
end
