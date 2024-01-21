class OrdersController < ApplicationController
    PAGE_SIZE = 5

    def customer_orders
        customer_id = params[:id]
        page_num = params[:page].present? ? params[:page].to_i : 1
        start_of_last_year = Date.new(Date.today.year - 1, 1, 1)
        start_index = (page_num - 1) * PAGE_SIZE
        end_index = start_index + PAGE_SIZE - 1
        @orders = Order.where('customer_id = ? AND ordered_at >= ?', customer_id, start_of_last_year)[start_index..end_index]
        @page_num = page_num
        @page_size = PAGE_SIZE

        render 'orders/index'
    end
end