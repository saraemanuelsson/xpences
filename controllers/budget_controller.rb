require('sinatra')
require('sinatra/contrib/all')
require('date')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/expense.rb')
require_relative('../models/budget.rb')
also_reload('../models/*')

get '/budget' do
    budget = Budget.current_budget
    @amount = budget.amount.to_f / 100
    end_date = Date.today
    start_date = Date.new(end_date.year, end_date.month, 1)
    expenses = Expense.find_expenses_for_given_period(start_date, end_date)
    spent_this_month = Expense.total_spent(expenses)
    @amount_spent = spent_this_month
    @budget_remaining = @amount - @amount_spent
    erb( :"budgets/index" )
end