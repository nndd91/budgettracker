require 'sinatra'
require 'data_mapper'
require_relative 'control.rb'

#Setting up Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/account.db")

class Account
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :amount, Float, :required => true, :default =>0.00
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
  @lastten = @accounts.first(10)
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
  @accounts = Account.all :order => :created_at.desc
  @total = 0
  @accounts.each do |account|
    @total += account.amount
  end
  erb :history
end

=begin
get '/history/:year' do
  year_filter = params[:year]
  @accounts = Account.all :year => year_filter, :order => :day.desc
  erb :history
end
=end

get '/history/:year/:month' do
  year_filter = params[:year].to_i
  month_filter = params[:month].to_i
  #@accounts = Account.all :year => year_filter, :month => month_filter, :order => :day.desc
  if year_filter == 0 && month_filter != 0
    @accounts = Account.all :month => month_filter, :order => :day.desc
  elsif month_filter == 0 && year_filter != 0
    @accounts = Account.all :year => year_filter, :order => :day.desc
  elsif year_filter == 0 && month_filter == 0
    @accounts = Account.all :order => :created_at.desc
  else
    @accounts = Account.all :year => year_filter, :month => month_filter, :order => :day.desc
  end
  @total = 0
  @accounts.each do |account|
    @total += account.amount
  end

  erb :history
end

post '/history' do
  year_filter = params[:yearin]
  month_filter = params[:monthin]
  url = '/history/' + year_filter + '/' + month_filter
  redirect url
end

post '/history/:year/:month' do
  year_filter = params[:yearin]
  month_filter = params[:monthin]
  url = '/history/' + year_filter + '/' + month_filter
  redirect url
end

