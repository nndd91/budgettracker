require 'sinatra'
require 'data_mapper'
require_relative 'control.rb'

#Setting up Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/account.db")

class Account
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :amount, Text, :required => true, :default =>0.00
  property :day, Integer
  property :month, Integer
  property :year, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do #Homepage
  @title = "Budget"
  @contenterr = ""
  @accounts = Account.all :order => :updated_at.desc
  @lastten = @accounts.last(10)
  erb :home
end

post '/' do
  acc = Account.new
  acc.content = params[:content]
  acc.amount = params[:amount]
  date = date_split(params[:date])
  acc.day = date[0]
  acc.month = date[1]
  acc.year = date[2]
  acc.created_at = Time.now
  acc.updated_at = Time.now
  acc.save
  redirect '/'
end

get '/history' do
  @accounts = Account.all :order => :created_at
  erb :history
end
