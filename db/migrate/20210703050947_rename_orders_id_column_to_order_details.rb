class RenameOrdersIdColumnToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_details, :orders_id, :order_id
  end
end
