require "rails_helper"

RSpec.describe Account, type: :model do
  let(:bank) { Bank.create(name: "BANK A") }
  let(:account_a) { Account.create(name: "Super account", holder: "Jim", bank: bank) }
  let(:account_b) { Account.create(name: "Super account B", holder: "Enma", bank: bank) }

  it "should have a name" do
    account_a.name.clear
    expect(account_a).not_to be_valid
  end

  it "should have a holder" do
    account_a.holder.clear
    expect(account_a).not_to be_valid
  end

  it "should have a related bank" do
    expect(account_a.bank).to eql bank
  end

  it "should have sent/received transfers" do
    transfer = Transfer.create(account_from: account_a, account_to: account_b, quantity: 10)
    expect(account_a.sent_transfers).to include transfer
    expect(account_b.received_transfers).to include transfer
  end
end
