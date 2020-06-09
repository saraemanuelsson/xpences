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
        values = [@amount, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM budgets WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM budgets"
        SqlRunner.run(sql)
    end

end