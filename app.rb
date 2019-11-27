require 'sinatra'
require_relative 'lib/state'

class MyApp < Sinatra::Base
  get '/' do
    erb :index, locals: { state: State.new }
  end
end
