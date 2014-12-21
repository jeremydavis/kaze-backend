class PayeesController < ApplicationController
  before_action :set_payee, only: [:show, :edit, :update, :destroy]

  def index
    @payees = Payee.all
    respond_with(@payees)
  end

  def show
    respond_with(@payee)
  end

  def new
    @payee = Payee.new
    respond_with(@payee)
  end

  def edit
  end

  def create
    @payee = Payee.new(payee_params)
    @payee.save
    respond_with(@payee)
  end

  def update
    @payee.update(payee_params)
    respond_with(@payee)
  end

  def destroy
    @payee.destroy
    respond_with(@payee)
  end

  private
    def set_payee
      @payee = Payee.find(params[:id])
    end

    def payee_params
      params.require(:payee).permit(:nickname, :account_holder, :account_number, :bank_name, :branch_name)
    end
end
