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
        case @amount_this_term
        when 0...MIN_SILVER_AMOUNT
            1
        when MIN_SILVER_AMOUNT...MIN_GOLD_AMOUNT
            2
        else
            3
        end
    end

    def calculate_amount_to_next_rank
        case @current_rank
        when 1
            MIN_SILVER_AMOUNT - @amount_this_term
        when 2
            MIN_GOLD_AMOUNT - @amount_this_term
        else
            0
        end.clamp(0, Float::INFINITY)
    end

    def calculate_downgrade_rank
        case @current_rank
        when 1
            0
        when 2
            MIN_SILVER_AMOUNT - @amount_this_term
        else
            MIN_GOLD_AMOUNT - @amount_this_term
        end.clamp(0, Float::INFINITY)
    end
end

