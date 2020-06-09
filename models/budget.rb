require_relative('../db/sql_runner')

class Budget

    attr_accessor :amount
    attr_reader :id

    def initialize(options)
        @amount = options['amount']
        @id = options['id'].to_i if options['id']
    end

end