require 'yaml'

require_relative 'azure'
require_relative 'github'
require_relative 'build'
require_relative 'diff'

class State
  def master_broken?
    qa_builds.first.failed?
  end

  def deploy_to_production_failed?
    latest_build_to('production').failed?
  end

  def deploying_to_staging?
    latest_build_to('staging').in_progress?
  end

  def deploying_to_production?
    latest_build_to('production').in_progress?
  end

  def staging_and_production_not_in_sync?
    latest_successfull_build_to('staging').commit_sha != latest_successfull_build_to('production').commit_sha
  end

  def latest_build_to(environment)
    return qa_builds.first if environment == 'qa'

    release_builds.find do |build|
      build.params["deploy_#{environment}"] == "true"
    end
  end

  def latest_successfull_build_to(environment)
    return latest_successfull_build_to_qa if environment == 'qa'

    release_builds.find do |build|
      build.succeeded? && build.params["deploy_#{environment}"] == "true"
    end
  end

  def deploying_to_qa?
    qa_builds.first.in_progress?
  end

private

  def latest_successfull_build_to_qa
    @latest_successfull_build_to_qa ||= qa_builds.find(&:succeeded?)
  end

  def qa_builds
    @qa_builds ||= begin
      params = {
        'api-version' => '5.1',
        'definitions' => 49, # CI pipeline ID
        'branchName' => 'refs/heads/master',
      }

      Azure.get("/build/builds", params)
    end
  end

  def release_builds
    @raw_builds ||= begin
      params = {
        'api-version' => '5.1',
        'definitions' => 325, # release pipeline ID
      }

      Azure.get("/build/builds", params)
    end
  end
end
