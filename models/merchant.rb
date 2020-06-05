require_relative('../db/sql_runner')

class Merchant

    attr_accessor :name, :active
    attr_reader :id

    def initialize(options)
        @name = options['name']
        @active = options['active']
        @id = options['id'].to_i if options['id']
    end 

end