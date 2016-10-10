class AddTextedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :texted_at, :datetime
  end
end
