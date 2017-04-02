# == Schema Information
#
# Table name: accounts
#
#  id             :integer          not null, primary key
#  name           :string
#  holder         :string
#  bank_id        :integer
#  current_credit :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_accounts_on_bank_id  (bank_id)
#

class Account < ApplicationRecord
  belongs_to :bank

  has_many :sent_transfers, class_name: "Transfer", foreign_key: "account_from_id"
  has_many :received_transfers, class_name: "Transfer", foreign_key: "account_to_id"

  validates_presence_of :name, :holder
end
