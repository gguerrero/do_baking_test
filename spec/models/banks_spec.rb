# == Schema Information
#
# Table name: banks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Bank, type: :model do
  it "should have a unique name" do
    bank_a = Bank.create(name: "BANK NAME")
    bank_b = Bank.create(name: "BANK NAME")

    expect(bank_b.errors[:name]).to include "has already been taken"
    expect(Bank.count).to eql 1
  end
end
