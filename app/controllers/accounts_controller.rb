class AccountsController < InheritedResources::Base

  private

    def account_params
      params.require(:account).permit(:account_number, :currency_id, :balance)
    end
end

