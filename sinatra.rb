require 'sinatra'
require 'yaml/store'
require 'rest-client'

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

get '/' do
  @title = 'Welcome to the Sinatra Takeout!'

  erb :index
end

post '/cast' do
  @title = 'Thanks for voting!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end

  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }

  erb :results
end

get '/meetups' do
  @store = YAML::Store.new 'keys.yml'
  meetup_api_key = nil

  @store.transaction do
    meetup_api_key = @store['keys']['meetup_api_key'] if keys = @store['keys']
  end

  @meetups = []
  unless meetup_api_key.nil?
    api_result = RestClient.get("http://api.meetup.com/groups.json/?&topic=ruby&order=members&key=#{meetup_api_key}")
    jhash = JSON.parse(api_result)

    @counter = jhash['results'].count
    jhash['results'].each do |j|
      @meetups << { name: j['name'],
                    city: j['city'],
                    focus: j['who'],
                    count: j['members'],
                    contact: j['organizer_name'],
                    link: j['link'],
                    country: j['country']
                  }
    end
  end

  erb :meetups
end
