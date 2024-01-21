class CreateCustomersAndOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :customers, id: false do |t|
      t.string :customer_id, primary_key: true, index: true
      t.string :name
      t.integer :current_rank
      t.datetime :rank_start_date
      t.decimal :amount_this_term

      t.timestamps
    end

    create_table :orders, id: false do |t|
      t.decimal :total
      t.datetime :ordered_at
      t.string :order_id, primary_key: true
      t.string :external_customer_id
    end 

    add_foreign_key :orders, :customers, column: :external_customer_id, primary_key: :customer_id
  end
end