class PayeesController < InheritedResources::Base

  private

    def payee_params
      params.require(:payee).permit(:nickname, :account_holder, :account_number, :bank_name, :branch_name)
    end
end

