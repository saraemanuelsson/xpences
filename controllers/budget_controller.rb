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
    current_date = Date.today
    first_date_of_month = Date.new(current_date.year, current_date.month, 1)
    expenses = Expense.find_expenses_for_given_period(first_date_of_month, current_date)
    @amount_spent = Expense.total_spent(expenses)
    @budget_remaining = @budget.budget_remaining(@amount_spent)
    @percentage_spent = @budget.percentage(@amount_spent)
    @percentage_remaining = @budget.percentage(@budget_remaining)
    @target = @budget.target_for_given_date(current_date)
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