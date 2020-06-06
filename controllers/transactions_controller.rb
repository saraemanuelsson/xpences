require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')
require('pry')

get '/add-expense' do
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :new_expense )
end

get '/expenses' do
    @transactions = Transaction.all()
    erb( :expenses )
end

post '/expenses' do
    expense = Transaction.new(params)
    expense.save()
    redirect( '/expenses' )
end

get '/expenses/:id/edit-expense' do
    @transaction = Transaction.find_by_id(params[:id])
    erb( :edit_transaction)
end

