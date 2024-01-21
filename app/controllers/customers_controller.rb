class CustomersController < ApplicationController
    MIN_SILVER_AMOUNT = 100
    MIN_GOLD_AMOUNT = 500

    def rank_info
        @customer = Customer.find(params[:id])

        @current_rank = @customer.current_rank
        @start_date = @customer.rank_start_date
        @amount_this_term = @customer.amount_this_term
        @amount_to_next_rank = calculate_amount_to_next_rank
        @next_year_rank = calculate_next_year_rank
        @downgrade_date = Date.new(Date.today.year, 12, 31)
        @downgrade_rank = calculate_downgrade_rank
        
        render 'rank_info'
    end

    private

    def calculate_next_year_rank
        if @amount_this_term < MIN_SILVER_AMOUNT
            next_year_rank = 1
        elsif MIN_SILVER_AMOUNT <= @amount_this_term && @amount_this_term < MIN_GOLD_AMOUNT
            next_year_rank = 2
        else 
            next_year_rank = 3
        end

        return next_year_rank
    end

    def calculate_amount_to_next_rank
        case @current_rank
        when 1
            amount_to_next_rank = MIN_SILVER_AMOUNT - @amount_this_term > 0 ? MIN_SILVER_AMOUNT - @amount_this_term : 0
        when 2
            amount_to_next_rank = MIN_GOLD_AMOUNT - @amount_this_term > 0 ? MIN_GOLD_AMOUNT - @amount_this_term : 0
        else
            amount_to_next_rank = 0
        end

        return amount_to_next_rank
    end

    def calculate_downgrade_rank
        case @current_rank
        when 1
            downgrade_rank = 0
        when 2
            downgrade_rank = MIN_SILVER_AMOUNT - @amount_this_term >= 0 ? MIN_SILVER_AMOUNT - @amount_this_term : 0
        else
            downgrade_rank = MIN_GOLD_AMOUNT - @amount_this_term > 0 ? MIN_GOLD_AMOUNT - @amount_this_term : 0
        end

        return downgrade_rank
    end
end

