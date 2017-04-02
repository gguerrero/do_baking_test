class TransferAgentJob < ApplicationJob
  queue_as :default

  def perform(account_from_id:, account_to_id:, quantity_to_transfer:)
    @account_from = Account.find(account_from_id)
    @account_to   = Account.find(account_to_id)

    if transfer_type.max_per_transfer.nil? # No max quantity for each transaction, perform a single transfer
      create_transfer_job(quantity_to_transfer, transfer_type.commission)
    else # Do n+1 transfers until finish
      (quantity_to_transfer/transfer_type.max_per_transfer).times do
        create_transfer_job(transfer_type.max_per_transfer, transfer_type.commission)
      end

      last_remaining_to_transfer = (quantity_to_transfer%transfer_type.max_per_transfer)
      if not last_remaining_to_transfer == 0
        create_transfer_job(last_remaining_to_transfer, transfer_type.commission) 
      end
    end
  end

  private
  # IMPROVE: This may be placed in a module that decides de logic of transfer types in the future
  def transfer_type
    transfer_type_name = if @account_from.bank.name == @account_to.bank.name
      "INTRA-BANK"
    else
      "INTER-BANK"
    end
    @transfer_type ||= TransferType.find_by(name: transfer_type_name)
  end

  def create_transfer_job(quantity, commission)
    transfer = Transfer.create!(account_from: @account_from,
                                account_to: @account_to,
                                quantity: quantity,
                                commission: commission)
    TransferJob.perform_now(transfer_id: transfer.id) # TODO: Convert in perform_later, have to look why transactions fails on sub jobs...
  end
end
