class CreateHdis < ActiveRecord::Migration
  def change
    create_table :hdis do |t|
      t.float :hdi_value_2012
      t.timestamps
    end
  end
end
