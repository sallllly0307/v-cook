class AddOccupationAgeAddressDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :occupation, :string
    add_column :users, :age, :string
    add_column :users, :address, :string
    add_column :users, :detail, :text
  end
end
