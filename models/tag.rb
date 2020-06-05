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
end