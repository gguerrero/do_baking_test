# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  completed_at    :datetime
#  status_code     :integer
#  status_message  :string
#  account_from_id :integer
#  account_to_id   :integer
#  quantity        :integer
#  commission      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Transfer < ApplicationRecord
  belongs_to :account_from, class_name: "Account"
  belongs_to :account_to,   class_name: "Account"

  enum status_code: %i(completed failed error)

  def completed?
    self.status_code == 'completed'
  end

end
