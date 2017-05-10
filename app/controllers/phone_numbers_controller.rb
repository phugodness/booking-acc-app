class PhoneNumbersController < ApplicationController
  def new
    @phone_number = PhoneNumber.new
  end

  def create
    @phone_number = PhoneNumber.find_or_create_by(phone_number_params)
    @phone_number.generate_pin
    @phone_number.send_pin
    respond_to do |format|
      format.js
    end
  end

  def verify
    @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
    @phone_number.verify(params[:pin])
    respond_to do |format|
      format.js
    end
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:user_id, :phone_number, :pin, :verified)
  end
end
