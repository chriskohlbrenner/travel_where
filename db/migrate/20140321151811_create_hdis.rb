class CreateHdis < ActiveRecord::Migration
  def change
    create_table :hdis do |t|
      t.float :hdi_value_2012
      t.integer :country_id
      t.timestamps
    end
  end
end