require 'rails_helper'

RSpec.describe TransferAgentJob, type: :job do
  let(:bank_a) { Bank.create(name: "BANK A") }
  let(:bank_b) { Bank.create(name: "BANK B") }
  let(:account_a) { Account.create(name: "Super account A",
                                   holder: "Jim",
                                   bank: bank_a,
                                   current_credit: 2500) }
  let(:account_b) { Account.create(name: "Super account B",
                                   holder: "Enma",
                                   bank: bank_b,
                                   current_credit: 200) }
  let(:account_c) { Account.create(name: "Super account C",
                                   holder: "Tom",
                                   bank: bank_a,
                                   current_credit: 400) }

  before(:all) do
    TransferType.create(name: "INTRA-BANK", commission: 0, max_per_transfer: nil)
    TransferType.create(name: "INTER-BANK", commission: 15, max_per_transfer: 100)
  end

  after(:all) do
    TransferType.destroy_all
  end

  it "should create n+1 transfer job when max per transfer exceded" do
    TransferAgentJob.perform_now(account_from_id: account_a.id,
                                 account_to_id: account_b.id,
                                 quantity_to_transfer: 502)

    account_a.reload
    account_b.reload

    expect(account_a.current_credit).to eql 1908 # 2500 - 502 - (6*15)
    expect(account_b.current_credit).to eql 702  # 200 + 502
  end

  it "should create only one transfer job when there is not max per transfer" do
    TransferAgentJob.perform_now(account_from_id: account_a.id,
                                 account_to_id: account_c.id,
                                 quantity_to_transfer: 1000)

    account_a.reload
    account_c.reload

    expect(account_a.current_credit).to eql 1500 # 2500 - 1000
    expect(account_c.current_credit).to eql 1400 # 400 + 1000
  end

end
