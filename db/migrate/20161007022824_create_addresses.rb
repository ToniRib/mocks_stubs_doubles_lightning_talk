class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :street_address
      t.string :zipcode
      t.references :user, index: true, foreign_key: true
      t.string :type_of

      t.timestamps null: false
    end
  end
end
