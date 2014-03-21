class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :hdi_id
      t.timestamps
    end
  end
end
