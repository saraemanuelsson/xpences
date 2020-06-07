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
    @expenses = Expense.all()
    @end_date = Date.today
    @start_date = Date.new(@end_date.year, @end_date.month, 1)
    @expenses = Expense.find_expenses_for_given_period(@start_date, @end_date)
    @month_total = Expense.total_spent(@expenses)
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

post '/expenses/dates' do
    start_date = params['start-date']
    end_date = params['end-date']
    redirect( "/expenses/dates/#{start_date}/#{end_date}")
end

get '/expenses/dates/:start_date/:end_date' do
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @expenses = Expense.find_expenses_for_given_period(@start_date, @end_date)
    @period_total = Expense.total_spent(@expenses)
    erb( :"expenses/dates")
end


