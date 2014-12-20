class TransfersController < InheritedResources::Base

  private

    def transfer_params
      params.require(:transfer).permit :account_id,
                                       :payee_id,
                                       :currency_id,
                                       :value,
                                       :description,
                                       :transfer_date,
                                       :repeat,
                                       :repeat_until,
                                       :transaction_password
    end
end

