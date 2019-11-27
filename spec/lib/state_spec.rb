require 'vcr'
require 'state'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe State do
  context 'a deploy to production failed' do
    it 'reports the correct data' do
      VCR.use_cassette("deploy-to-production-failed") do
        state = State.new

        expect(state.master_broken?).to be false
        expect(state.deploy_to_production_failed?).to be true
        expect(state.deploying_to_production?).to be false
        expect(state.latest_successfull_build_to('production').commit_sha).to eql('1caecfa6b960213e33b30a4fc37d9d5637afa47d')
      end
    end
  end

  context 'a deploy to production in progress' do
    it 'reports the correct data' do
      VCR.use_cassette("deploy-to-production-in-progress") do
        state = State.new

        expect(state.deploy_to_production_failed?).to be false
        expect(state.deploying_to_production?).to be true
      end
    end
  end
end
