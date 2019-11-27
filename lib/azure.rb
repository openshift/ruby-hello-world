require 'http'
require 'json'

class Azure
  ORGANISATION = 'dfe-ssp'
  PROJECT = 'Become-A-Teacher'

  # https://docs.microsoft.com/en-us/rest/api/azure/devops/build/builds/list?view=azure-devops-rest-5.1
  def self.get(path, params)
    api_response = HTTP
      .basic_auth(user: ENV.fetch("AZURE_USERNAME"), pass: ENV.fetch("AZURE_ACCESS_TOKEN"))
      .get(
      "https://dev.azure.com/#{ORGANISATION}/#{PROJECT}/_apis#{path}", params: params
    )

    builds = JSON.parse(api_response)['value'].sort_by { |b| b["queueTime"] }.reverse
    convert(builds)
  end

  def self.convert(builds)
    builds.map { |azure_build| Build.new(azure_build) }
  end
end
