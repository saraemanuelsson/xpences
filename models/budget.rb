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
        result = (amount * 100) / @amount.to_f
        return result * 100
    end

    def cent_amount_to_full(amount)
        full_amount = amount.to_f / 100
        return full_amount
    end

    def budget_remaining(amount_spent)
        return @amount -= amount_spent
    end

    def self.current_budget()
        sql = "SELECT * FROM budgets"
        budget_data = SqlRunner.run(sql)[0]
        budget = Budget.new(budget_data)
        return budget
    end

    def self.delete_all()
        sql = "DELETE FROM budgets"
        SqlRunner.run(sql)
    end

end