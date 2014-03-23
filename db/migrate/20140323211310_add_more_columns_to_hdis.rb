class AddMoreColumnsToHdis < ActiveRecord::Migration
  def change
    add_column :hdis, :expected_years_of_schooling, :string
    add_column :hdis, :mean_years_of_schooling, :string
    add_column :hdis, :hdi_rank, :string
    add_column :hdis, :gross_national_income_gni_per_capita, :string
    add_column :hdis, :life_expectancy_at_birth, :string
  end
end
