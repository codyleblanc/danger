module Danger
  # ### CI Setup
  #
  # Buddybuild has an integration for Danger already built-in.
  # What you need to do is to upload your `Gemfile` and `Dangerfile` to
  # the server and you should be all set-up. However, if you want to use
  # different bot for Danger, you can do it with token setup described below.
  #
  # ### Token Setup
  #
  # Login to buddybuild and select your app. Go to your *App Settings* and
  # in the *Build Settings* menu on the left, choose *Environment Variables*.
  #
  # #### GitHub
  # Add the `DANGER_GITHUB_API_TOKEN` to your build user's ENV.
  #
  # #### GitLab
  # Add the `DANGER_GITLAB_API_TOKEN` to your build user's ENV.

  class Buddybuild < CI

    def self.validates_as_ci?(env)
      env.key? "BUDDYBUILD_BUILD_NUMBER"
    end

    def self.validates_as_pr?(env)
      env.key? "BUDDYBUILD_PULL_REQUEST"
    end

    def supported_request_sources
      @supported_request_sources ||= [
        Danger::RequestSources::GitHub,
        Danger::RequestSources::GitLab,
        Danger::RequestSources::BitbucketCloud
      ]
    end

    def initialize(env)
      self.repo_slug = env["BUDDYBUILD_REPO_SLUG"]
      self.pull_request_id = env["BUDDYBUILD_PULL_REQUEST"]
      self.repo_url = GitRepo.new.origins # Buddybuild doesn't provide a repo url env variable :/
    end

  end

end

