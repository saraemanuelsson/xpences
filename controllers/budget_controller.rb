require('sinatra')
require('sinatra/contrib/all')
require('date')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/expense.rb')
require_relative('../models/budget.rb')
also_reload('../models/*')

get '/budget' do
    @budget = Budget.current_budget
    @amount = @budget.amount.to_f / 100
    end_date = Date.today
    start_date = Date.new(end_date.year, end_date.month, 1)
    expenses = Expense.find_expenses_for_given_period(start_date, end_date)
    @amount_spent = Expense.total_spent(expenses)
    @budget_remaining = @amount - @amount_spent
    @percentage_spent = @budget.percentage(@amount_spent)
    @percentage_remaining = @budget.percentage(@budget_remaining)
    days_in_month = (Date.new(end_date.year, end_date.month, -1)).day
    @target = (@budget.target_for_given_date(days_in_month, end_date.day)) / 100
    erb( :"budgets/index" )
end

get '/budget/:id/edit' do
    @budget = Budget.find_by_id(params[:id])
    erb( :"budgets/edit" )
end

post '/budget/:id/edit' do
    budget_to_update = Budget.new(params)
    budget_to_update.update()
    redirect( '/budget')
end