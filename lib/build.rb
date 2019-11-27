class Build
  def initialize(azure_build)
    @azure_build = azure_build
  end

  def start_time
    DateTime.parse(azure_build['queueTime']).strftime('%m/%d/%Y %I:%M%p')
  end

  def succeeded?
    result == "succeeded"
  end

  def failed?
    result == "failed"
  end

  def in_progress?
    result.nil?
  end

  def deployer_name
    name = azure_build['requestedBy']['displayName']
    name == 'Microsoft.VisualStudio.Services.TFS' ? 'Autodeploy' : name
  end

  def params
    azure_build['parameters'] ? JSON.parse(azure_build['parameters']) : nil
  end

  def link
    azure_build['_links']['web']['href']
  end

  def commit_sha
    azure_build['sourceVersion']
  end

  def diff_against_url(other_sha)
    "https://github.com/DFE-Digital/apply-for-postgraduate-teacher-training/compare/#{commit_sha}...#{other_sha}"
  end

private
  attr_reader :azure_build

  # https://docs.microsoft.com/en-us/rest/api/azure/devops/build/builds/list?view=azure-devops-rest-5.1#buildresult
  def result
    azure_build['result']
  end
end
