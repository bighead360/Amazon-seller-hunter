class FixSeriesName < ActiveRecord::Migration
  def change
  	rename_column :books, :Series, :series
  end
end
