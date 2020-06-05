require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/merchant')
require_relative('./models/tag')
require_relative('./models/transaction')
also_reload('./models/*')

get '/xpences' do
    @user = { 'first_name' => 'Anna', 'last_name' => 'Smith', 'age' => 21}
    erb( :home )
end