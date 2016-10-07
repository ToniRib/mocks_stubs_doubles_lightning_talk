class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :street_address
      t.string :zipcode
      t.string :phone

      t.timestamps null: false
    end
  end
end
