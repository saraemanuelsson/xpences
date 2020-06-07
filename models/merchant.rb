require_relative('../db/sql_runner')

class Merchant

    attr_accessor :name, :active
    attr_reader :id

    def initialize(options)
        @name = options['name']
        @active = options['active'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO merchants
        ( name, active )
        VALUES
        ( $1, $2 )
        RETURNING id"
        values = [@name, @active]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE merchants SET
        ( name, active )
        =
        ( $1, $2 )
        WHERE id = $3"
        values = [@name, @active, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM merchants WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def expenses()
        sql = "SELECT expenses.* FROM expenses
        INNER JOIN merchants
        ON merchants.id = expenses.merchant_id
        WHERE merchants.id = $1"
        values = [@id]
        expenses = SqlRunner.run(sql, values)
        return Expense.map_items(expenses)
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM merchants WHERE id = $1"
        values = [id]
        merchant = SqlRunner.run(sql, values)
        return Merchant.map_item(merchant)
    end

    def self.all()
        sql = "SELECT * FROM merchants"
        merchants = SqlRunner.run(sql)
        return Merchant.map_items(merchants)
    end

    def self.active()
        sql = "SELECT * FROM merchants WHERE active = $1"
        values = [1]
        active_merchants = SqlRunner.run(sql, values)
        return Merchant.map_items(active_merchants)
    end

    def self.delete_all()
        sql = "DELETE FROM merchants"
        SqlRunner.run(sql)
    end

    def self.map_items(merchant_data)
        result = merchant_data.map { |merchant| Merchant.new(merchant)}
        return result
    end

    def self.map_item(merchant_data)
        result = Merchant.map_items(merchant_data)
        return result.first
    end

end