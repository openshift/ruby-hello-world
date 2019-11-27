require 'octokit'

class GitHub
  def self.client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
  end
end
