require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/merchant')
require_relative('./models/tag')
require_relative('./models/transaction')
also_reload('./models/*')
require('pry')

get '/xpences' do
    @user = { 'first_name' => 'Anna', 'last_name' => 'Smith', 'age' => 21}
    erb( :home )
end

get '/xpences/add-expense' do
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :new_expense )
end

get '/xpences/expenses' do
    @transactions = Transaction.all()
    erb( :expenses )
end

post '/xpences' do
    expense = Transaction.new(params)
    expense.save()
    redirect( :expenses )
end