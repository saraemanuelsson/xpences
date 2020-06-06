require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')
require('pry')

get '/expenses/add' do
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :new_expense )
end

get '/expenses' do
    @transactions = Transaction.all()
    erb( :expenses )
end

post '/expenses/add' do
    expense = Transaction.new(params)
    expense.save()
    redirect( '/expenses' )
end

get '/expenses/:id/edit' do
    @transaction = Transaction.find_by_id(params[:id])
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :edit_transaction )
end

post '/expenses/:id/edit' do
    expense_to_update = Transaction.new(params)
    expense_to_update.update()
    redirect( '/expenses' )
end

post '/expenses/:id/delete' do
    expense = Transaction.find_by_id(params[:id])
    expense.delete()
    redirect( '/expenses' )
end



