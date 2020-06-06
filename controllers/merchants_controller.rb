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

post '/merchants' do
    merchant = Merchant.new(params)
    merchant.save()
    redirect( '/merchants' )
end

get '/merchants/:id/edit' do
    @merchant = Merchant.find_by_id(params[:id])
    erb( :edit_merchant )
end

post '/merchant/:id' do
    merchant_to_update = Merchant.new(params)
    merchant_to_update.update()
    redirect( '/merchants' )
end