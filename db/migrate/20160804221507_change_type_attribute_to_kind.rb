class ChangeTypeAttributeToKind < ActiveRecord::Migration
  def change
    rename_column :events, :type, :kind
  end
end
