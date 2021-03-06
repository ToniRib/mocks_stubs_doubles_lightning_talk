class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :shipped_on
      t.references :user, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
