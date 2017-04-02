class TransferJob < ApplicationJob
  queue_as :default

  def perform(transfer_id:)
    transfer = Transfer.find(transfer_id)
    return if transfer.completed?

    Transfer.transaction do
      account_from = transfer.account_from
      account_to = transfer.account_to

      account_from.current_credit -= (transfer.quantity + transfer.commission)
      account_to.current_credit   += transfer.quantity

      account_from.save!
      account_to.save!

      transfer.status_code = "completed"
      transfer.completed_at = DateTime.now
      transfer.save!
    end

  rescue => e
    transfer.status_code = "failed"
    transfer.save!
    raise e
  end
end
