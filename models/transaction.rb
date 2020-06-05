require_relative('../db/sql_runner')

class Transaction

    attr_accessor :amount, :merchant_id, :tag_id
    attr_reader :id

    def initialize(options)
        @amount = options['amount']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
    end

    def save()
        sql = "INSERT INTO transactions
        ( amount, merchant_id, tag_id )
        VALUES
        ( $1, $2, $3 )
        RETURNING id"
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

end