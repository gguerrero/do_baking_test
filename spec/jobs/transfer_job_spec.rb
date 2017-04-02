require 'rails_helper'

RSpec.describe TransferJob, type: :job do
  let(:bank_a) { Bank.create(name: "BANK A") }
  let(:bank_b) { Bank.create(name: "BANK B") }
  let(:account_a) { Account.create(name: "Super account A",
                                   holder: "Jim",
                                   bank: bank_a,
                                   current_credit: 2500) }
  let(:account_b) { Account.create(name: "Super account B",
                                   holder: "Enma",
                                   bank: bank_b,
                                   current_credit: 400) }
  let(:transfer) { Transfer.create(account_from: account_a,
                                   account_to: account_b,
                                   quantity: 1000,
                                   commission: 10) }

  it "should complete transfer successfully" do
    TransferJob.perform_now(transfer_id: transfer.id)
    
    transfer.reload
    account_a.reload
    account_b.reload

    expect(transfer.status_code).to eql "completed"
    expect(transfer.completed_at).not_to be_nil
    expect(account_a.current_credit).to eql 1490
    expect(account_b.current_credit).to eql 1400
  end

  it "should not perform changes when the transfer was already completed" do
    TransferJob.perform_now(transfer_id: transfer.id)

    transfer.reload
    account_a.reload
    account_b.reload

    expect(account_a.current_credit).to eql 1490
    expect(account_b.current_credit).to eql 1400
  end

end
