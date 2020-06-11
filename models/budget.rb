require('date')
require_relative('../db/sql_runner')

class Budget

    attr_accessor :amount
    attr_reader :id

    def initialize(options)
        @amount = options['amount'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO budgets (amount) VALUES ($1) RETURNING id"
        @amount = (@amount.to_f * 100.00).to_i
        values = [@amount]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE budgets SET amount = $1 WHERE id = $2"
        @amount = (@amount.to_f * 100.00).to_i
        values = [@amount, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM budgets WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def percentage(amount)
        result = (amount * 100.00) / @amount.to_f
        return result * 100
    end

    def budget_remaining(amount_spent)
        result = (@amount.to_f / 100) - amount_spent
        return result
    end

    def target_for_given_date(date)
        days_in_month = (Date.new(date.year, date.month, -1)).day
        daily_target = @amount.to_f / days_in_month
        target_for_date = daily_target * date.day
        return target_for_date.to_i / 100
    end

    def self.current_budget()
        sql = "SELECT * FROM budgets"
        budget_data = SqlRunner.run(sql)[0]
        budget = Budget.new(budget_data)
        return budget
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM budgets WHERE id = $1"
        values = [id]
        budget = SqlRunner.run(sql, values)
        return Budget.map_item(budget)
    end

    def self.delete_all()
        sql = "DELETE FROM budgets"
        SqlRunner.run(sql)
    end

    def self.map_items(budget_data)
        result = budget_data.map { |budget| Budget.new(budget)}
        return result
    end

    def self.map_item(budget_data)
        result = Budget.map_items(budget_data)
        return result.first
    end

end