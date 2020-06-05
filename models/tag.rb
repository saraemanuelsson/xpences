require_relative('../db/sql_runner')

class Tag

    attr_accessor :category, :colour, :active
    attr_reader :id

    def initialize(options)
        @category = options['category']
        @colour = options['category']
        @active = options['active']
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO tags
        ( category, colour, active )
        VALUES 
        ( $1, $2, $3 )
        RETURNING id"
        values = [@category, @colour, @active]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE tags SET
        ( category, colour, active)
        =
        ( $1, $2, $3 )
        WHERE id = $4"
        values = [@category, @colour, @active, @id]
        SqlRunner.run(sql, values)
    end

end