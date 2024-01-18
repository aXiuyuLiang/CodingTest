class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :current_rank
      t.datetime :rank_start_date
      t.decimal :amount_this_term

      t.timestamps
    end
  end
end
