require_relative('../db/sql_runner')

class Expense

    attr_accessor :amount, :merchant_id, :tag_id, :date
    attr_reader :id

    def initialize(options)
        @amount = options['amount']
        @date = options['date']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO expenses
        ( amount, date, merchant_id, tag_id )
        VALUES
        ( $1, $2, $3, $4 )
        RETURNING id"
        @amount = (@amount.to_f * 100.00).to_i
        values = [@amount, @date, @merchant_id, @tag_id]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE expenses SET
        ( amount, date, merchant_id, tag_id )
        =
        ( $1, $2, $3, $4)
        WHERE id = $5"
        @amount = (@amount.to_f * 100.00).to_i
        values = [@amount, @date, @merchant_id, @tag_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM expenses WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.total_spent(expenses)
        total = expenses.reduce(0) { |running_total, expense| running_total + expense.amount.to_i }
        gbp_amount = total.to_f/100.00
        return gbp_amount
    end

    def self.find_expenses_for_given_period(start_date, end_date)
        sql = "SELECT * FROM expenses WHERE date BETWEEN $1 AND $2 ORDER BY date DESC"
        values = [start_date, end_date]
        expenses_for_period = SqlRunner.run(sql, values)
        return Expense.map_items(expenses_for_period)
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM expenses WHERE id = $1"
        values = [id]
        expense = SqlRunner.run(sql, values)
        return Expense.map_item(expense)
    end

    def self.find_by_tag(tag)
        sql = "SELECT * FROM expenses WHERE tag_id = $1 ORDER BY date DESC"
        values = [tag]
        expenses = SqlRunner.run(sql, values)
        return Expense.map_items(expenses)
    end

    def self.all()
        sql = "SELECT * FROM expenses ORDER BY date DESC"
        expenses = SqlRunner.run(sql)
        return Expense.map_items(expenses)
    end

    def self.delete_all()
        sql = "DELETE FROM expenses"
        SqlRunner.run(sql)
    end

    def self.map_items(expense_data)
        result = expense_data.map { |expense| Expense.new(expense)}
        return result
    end

    def self.map_item(expense_data)
        result = Expense.map_items(expense_data)
        return result.first
    end

end