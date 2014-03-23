class CreateHdis < ActiveRecord::Migration
  def change
    create_table :hdis do |t|
      t.float :hdi_value_2012, :precision => 4, :scale => 3
      t.integer :country_id
      t.timestamps
    end
  end
end
