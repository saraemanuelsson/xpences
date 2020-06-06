require_relative('../db/sql_runner')

class Tag

    attr_accessor :category, :colour, :active
    attr_reader :id

    def initialize(options)
        @category = options['category']
        @colour = options['colour']
        @active = 1
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

    def delete()
        sql = "DELETE FROM tags WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def transactions()
        sql = "SELECT transactions.* FROM transactions
        INNER JOIN tags
        ON tags.id = transactions.tag_id
        WHERE tags.id = $1"
        values = [@id]
        transactions = SqlRunner.run(sql, values)
        return Transaction.map_items(transactions)
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM tags WHERE id = $1"
        values = [id]
        tag = SqlRunner.run(sql, values)
        return Tag.map_item(tag)
    end

    def self.all()
        sql = "SELECT * FROM tags"
        tags = SqlRunner.run(sql)
        return Tag.map_items(tags)
    end

    def self.delete_all()
        sql = "DELETE FROM tags"
        SqlRunner.run(sql)
    end

    def self.map_items(tag_data)
        result = tag_data.map { |tag| Tag.new(tag)}
        return result
    end

    def self.map_item(tag_data)
        result = Tag.map_items(tag_data)
        return result.first
    end

end