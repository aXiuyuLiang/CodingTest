class OrdersController < ApplicationController
    def customer_orders
        customer_id = params[:id]
        start_of_last_year = Date.new(Date.today.year - 1, 1, 1)
        @orders = Order.where('customer_id = ? AND ordered_at >= ?', customer_id, start_of_last_year)
        render 'orders/index'

        # render json: @orders.map { |order| {id: order.id, date: order.ordered_at} }
    end
end
