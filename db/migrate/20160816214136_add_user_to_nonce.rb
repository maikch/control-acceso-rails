class AddUserToNonce < ActiveRecord::Migration
  def change
    add_reference :nonces, :user, index: true, foreign_key: true
  end
end
