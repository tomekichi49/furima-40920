class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params.merge(user_id: current_user.id, item_id: @item.id))

    if @purchase_form.save
      Payjp.api_key = "sk_test_0c5df3b245667609ff263aea"
      Payjp::Charge.create(
        amount: @item.price,
        card: @purchase_form.token,
        currency: 'jpy'
      )
      redirect_to root_path
    else
      puts @purchase_form.errors.full_messages
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token)
    .merge(token: params[:token])
  end
end