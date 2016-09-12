class CreateNonces < ActiveRecord::Migration
  def change
    create_table :nonces do |t|
      t.string :value
      t.boolean :active

      t.timestamps null: false
    end
  end
end
