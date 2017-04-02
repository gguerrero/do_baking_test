# == Schema Information
#
# Table name: transfer_types
#
#  id               :integer          not null, primary key
#  name             :string
#  commission       :integer
#  max_per_transfer :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TransferType < ApplicationRecord
  validates_uniqueness_of :name
  validates :commission, numericality: {greater_than_or_equal_to: 0}
  validates :max_per_transfer, numericality: {greater_than: 0}, allow_blank: true
end
