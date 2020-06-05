require_relative('../db/sql_runner')

class Transaction

    attr_accessor :amount, :merchant_id, :tag_id
    attr_reader :id

    def initialize(options)
        @amount = options['amount']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
    end


end