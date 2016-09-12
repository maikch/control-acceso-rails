class ChangeTemplateToText < ActiveRecord::Migration
  def change
    change_column :users, :template, :text
  end
end
