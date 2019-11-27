ENV['APP_ENV'] = 'test'

require_relative '../app'
require 'rspec'
require 'rack/test'

RSpec.describe 'The Apply Ops Dashboard' do
  include Rack::Test::Methods

  def app
    MyApp
  end

  it "works" do
    VCR.use_cassette('full-page-request') do
      get '/'
    end

    expect(last_response).to be_ok
  end
end
