require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')
require('pry')

get '/tags' do
    @tags = Tag.all()
    erb( :"tags/index" )
end

get '/tags/new' do
    erb( :"tags/new" )
end

post '/tags' do
    tag = Tag.new(params)
    tag.save()
    redirect( '/tags' )
end

get '/tags/:id/edit' do
    @tag = Tag.find_by_id(params[:id])
    # binding.pry()
    erb( :"tags/edit" )
end

post '/tags/:id' do
    tag_to_update = Tag.new(params)
    tag_to_update.update()
    redirect( '/tags' )
end