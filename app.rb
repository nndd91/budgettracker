require 'sinatra'
require 'data_mapper'

#Setting up Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/account.db")

class Account
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :amount, Text, :required => true, :default =>0.00
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do #Homepage
  @title = "Budget"
  @contenterr = ""
  erb :home
end

post '/' do
  validated = true
  acc = Account.new
  if params[:content] = ""
    @contenterr = "Please input content!"
    validated = false
  else
    acc.content = params[:content]
  end
  acc.amount = params[:amount]
  acc.created_at = Time.now
  acc.updated_at = Time.now
  if validated
    acc.save

  end
  redirect '/'
end

get '/history' do
  erb :history
end
