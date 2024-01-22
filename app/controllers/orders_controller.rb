class OrdersController < ApplicationController
    PAGE_SIZE = 5
    MIN_SILVER_AMOUNT = 100
    MIN_GOLD_AMOUNT = 500

    def customer_orders
        @customer_id = params[:id]
        page_num = params[:page].present? ? params[:page].to_i : 1
        start_of_last_year = Date.new(Date.today.year - 1, 1, 1)
        start_index = (page_num - 1) * PAGE_SIZE
        end_index = start_index + PAGE_SIZE - 1
        @orders = Order.where('external_customer_id = ? AND ordered_at >= ?', @customer_id, start_of_last_year)[start_index..end_index]
        @page_num = page_num
        @page_size = PAGE_SIZE

        render 'orders/index'
    end

    def create
        customer_id = params[:customerId]
        customer_name = params[:customerName]
        order_id = params[:orderId]
        total_in_cents = params[:totalInCents]
        date = params[:date]

        ActiveRecord::Base.transaction do
            customer = Customer.find_or_initialize_by(customer_id: customer_id)
            if customer.new_record?
                customer.name = customer_name
                customer.amount_this_term = total_in_cents / 100.0
                customer.rank_start_date = Date.new(Date.today.year - 1, 1, 1)
            else
                customer.amount_this_term += total_in_cents / 100.0
            end
            customer.current_rank = calculate_current_rank(customer.amount_this_term)
            customer.save!

            order = Order.new(order_id: order_id, external_customer_id: customer.customer_id, total: total_in_cents / 100.0, ordered_at: date)
            order.save!
        end
        rescue ActiveRecord::RecordInvalid => e
    end

    private

    def calculate_current_rank(total_amount)
        case total_amount
        when 0...MIN_SILVER_AMOUNT
            1
        when MIN_SILVER_AMOUNT...MIN_GOLD_AMOUNT
            2
        else
            3
        end
    end
end