class AddAddressToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :gmaps, :boolean
  end

  def self.down
    remove_column :users, :gmaps
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :address
  end
end
