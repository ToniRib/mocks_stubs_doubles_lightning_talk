class AddLabelStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :label_status, :string
  end
end
