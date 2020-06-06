require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/transactions_controller')
require_relative('controllers/merchants_controller')
require_relative('controllers/tags_controller')
require_relative('controllers/user_controller')

get '/' do
    @user = { 'first_name' => 'Anna', 'last_name' => 'Smith', 'age' => 21}
    erb( :home )
end