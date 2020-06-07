require('sinatra')
require('sinatra/contrib/all')
require('date')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/expense.rb')
also_reload('../models/*')
require('pry')

get '/expenses/add' do
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :"expenses/new" )
end

get '/expenses' do
    @expenses = Expense.sort_by_date()
    @current_date = Date.today
    @first_day_of_month = Date.new(@current_date.year, @current_date.month, 1)
    expenses_this_month = Expense.find_expenses_for_given_period(@first_day_of_month, @current_date)
    @month_total = Expense.total_spent(expenses_this_month)
    erb( :"expenses/index" )
end

post '/expenses/add' do
    expense = Expense.new(params)
    expense.save()
    redirect( '/expenses' )
end

get '/expenses/:id/edit' do
    @expense = Expense.find_by_id(params[:id])
    @merchants = Merchant.all()
    @tags = Tag.all()
    erb( :"expenses/edit" )
end

post '/expenses/:id/edit' do
    expense_to_update = Expense.new(params)
    expense_to_update.update()
    redirect( '/expenses' )
end

post '/expenses/:id/delete' do
    expense = Expense.find_by_id(params[:id])
    expense.delete()
    redirect( '/expenses' )
end



