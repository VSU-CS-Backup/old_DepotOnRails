class AddLonglatToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :longitude, :float
    add_column :orders, :latitude, :float
    add_column :orders, :gmaps, :boolean
  end

  def self.down
    remove_column :orders, :gmaps
    remove_column :orders, :latitude
    remove_column :orders, :longitude
  end
end
