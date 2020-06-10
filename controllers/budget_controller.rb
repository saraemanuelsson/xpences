require('sinatra')
require('sinatra/contrib/all')
require('date')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/expense.rb')
also_reload('../models/*')

get '/budget' do
    @budget = Budget.current_budget
    erb( :"budget/index" )
end