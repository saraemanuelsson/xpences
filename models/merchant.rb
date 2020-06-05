require_relative('../db/sql_runner')

class Merchant

    attr_accessor :name, :active
    attr_reader :id

    def initialize(options)
        @name = options['name']
        @active = options['active']
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

end