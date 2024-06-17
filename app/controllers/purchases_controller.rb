class PurchasesController < ApplicationController

  def index
  end

  def new
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
  end
end