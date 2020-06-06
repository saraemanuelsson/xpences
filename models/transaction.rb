require_relative('../db/sql_runner')

class Transaction

    attr_accessor :amount, :merchant_id, :tag_id
    attr_reader :id

    def initialize(options)
        @amount = options['amount']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO transactions
        ( amount, merchant_id, tag_id )
        VALUES
        ( $1, $2, $3 )
        RETURNING id"
        @amount = (@amount.to_f * 100.00).to_i
        values = [@amount, @merchant_id, @tag_id]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE transactions SET
        ( amount, merchant_id, tag_id )
        =
        ( $1, $2, $3)
        WHERE id = $4"
        values = [@amount, @merchant_id, @tag_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM transactions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.total_spent(transactions)
        total = transactions.reduce(0) { |running_total, transaction| running_total + transaction.amount.to_i }
        gbp_amount = total.to_f/100.00
        return gbp_amount
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM transactions WHERE id = $1"
        values = [id]
        transaction = SqlRunner.run(sql, values)
        return Transaction.map_item(transaction)
    end

    def self.all()
        sql = "SELECT * FROM transactions"
        transactions = SqlRunner.run(sql)
        return Transaction.map_items(transactions)
    end

    def self.delete_all()
        sql = "DELETE FROM transactions"
        SqlRunner.run(sql)
    end

    def self.map_items(transaction_data)
        result = transaction_data.map { |transaction| Transaction.new(transaction)}
        return result
    end

    def self.map_item(transaction_data)
        result = Transaction.map_items(transaction_data)
        return result.first
    end

end