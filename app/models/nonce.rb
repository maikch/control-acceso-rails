class Nonce < ActiveRecord::Base
  belongs_to :user
  validates :value, :user, presence: true
end

# == Schema Information
#
# Table name: nonces
#
#  id         :integer          not null, primary key
#  value      :string(255)
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_nonces_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_e863863cd1  (user_id => users.id)
#
