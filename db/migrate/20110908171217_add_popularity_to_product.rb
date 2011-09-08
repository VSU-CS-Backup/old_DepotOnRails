class AddPopularityToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :popularity, :decimal, :default => 0
  end

  def self.down
    remove_column :products, :popularity
  end
end
