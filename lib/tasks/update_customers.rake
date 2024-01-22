namespace :update_customers do
  desc "Update customers' info"
  task update: :environment do
    Customer.find_each do |customer|
      start_of_this_year = Date.new(Date.today.year, 1, 1)
      total_amount = Order.where('customer_id = ? AND ordered_at >= ?', customer.id, start_of_this_year).sum(:total)

      current_rank = case total_amount
        when 0...MIN_SILVER_AMOUNT
            1
        when MIN_SILVER_AMOUNT...MIN_GOLD_AMOUNT
            2
        else
            3
        end

      customer.update(
        current_rank: current_rank,
        rank_start_date: start_of_this_year,
        amount_this_term: total_amount
      )
    end
  end
end
