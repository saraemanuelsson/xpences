require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')
require('pry')

get '/merchants' do
    @merchants = Merchant.all()
    erb( :merchants )
end

get '/merchants/new' do
    erb( :new_merchant)
end