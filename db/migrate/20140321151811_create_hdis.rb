class CreateHdis < ActiveRecord::Migration
  def change
    create_table :hdis do |t|
      t.string :hdi_value
      t.integer :country_id
      t.timestamps
    end
  end
end
