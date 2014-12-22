class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    @transfers = Transfer.includes(:currency, :account, :payee).all
    respond_with(@transfers)
  end

  def show
    respond_with(@transfer)
  end

  def new
    @transfer = Transfer.new
    respond_with(@transfer)
  end

  def edit
  end

  def create
    @transfer = Transfer.new(create_params)
    @transfer.save
    respond_with(@transfer)
  end

  def update
    @transfer.update(update_params)
    respond_with(@transfer)
  end

  def destroy
    @transfer.destroy
    respond_with(@transfer)
  end

  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def create_params
      params.require(:transfer).permit :account_id,
                                       :payee_id,
                                       :currency_id,
                                       :value,
                                       :description,
                                       :transfer_date,
                                       :repeat,
                                       :repeat_until,
                                       :initiated_at,
                                       :transaction_password,
                                       :one_time_password,
                                       :transaction_hash
    end

    def update_params
      params.require(:transfer).permit :description
    end
end
