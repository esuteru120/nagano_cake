class ChangeAddressesToShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    rename_table :addresses, :shipping_addresses
  end
end
