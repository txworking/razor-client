require 'project_razor/constants'
require 'project_razor/client/request'
require 'project_razor/client/response'
require 'project_razor/client/policy'
require 'project_razor/client/model'
require 'project_razor/client/active_model'
require 'project_razor/client/bmc'
require 'project_razor/client/broker'
require 'project_razor/client/image'
require 'project_razor/client/node'
require 'project_razor/client/tag'
require 'project_razor/exception'
require 'project_razor/logging'

module ProjectRazor
  # This is a Ruby wrapper for the ProjectRazor API
  class Client
    include ProjectRazor::Client::Request
    include ProjectRazor::Client::Response
    include ProjectRazor::Client::Policy
    include ProjectRazor::Client::Model
    include ProjectRazor::Client::Bmc
    include ProjectRazor::Client::Active_model
    include ProjectRazor::Client::Broker
    include ProjectRazor::Client::Image
    include ProjectRazor::Client::Node
    include ProjectRazor::Client::Tag

    include ProjectRazor::Logging

    # Returns the HTTP connection adapter that will be used to connect.
    attr_reader :net_adapter
    # Returns the Proxy URL that will be used to connect.
    attr_reader :proxy_url
    # Returns the ProjectRazor API Target URL.
    attr_reader :target_url
    # Returns the ProjectRazor API Trace Key.
    attr_reader :trace_key
    # Returns the ProjectRazor API Authorization Token.
    attr_reader :auth_token
    # Returns the ProjectRazor Logged User.
    attr_reader :user
    # Returns the ProjectRazor Proxied User.
    attr_reader :proxy_user

    # Creates a new ProjectRazor::Client object.
    #
    # @param [Hash] options
    # @option options [Faraday::Adapter] :adapter The HTTP connection adapter that will be used to connect.
    # @option options [String] :proxy_url The Proxy URL that will be used to connect.
    # @option options [String] :target_url The ProjectRazor API Target URL.
    # @option options [String] :trace_key The ProjectRazor API Trace Key.
    # @option options [String] :auth_token The ProjectRazor API Authorization Token.
    # @return [ProjectRazor::Client] A ProjectRazor::Client Object.
    # @raise [ProjectRazor::Client::Exception::BadParams] when target_url is not a valid ProjectRazor API URL.
    # @raise [ProjectRazor::Client::Exception::AuthError] when auth_token is not a valid ProjectRazor API authorization token.
    def initialize(options = {})
      @net_adapter = options[:adapter] || ProjectRazor::DEFAULT_ADAPTER
      @proxy_url = options[:proxy_url] || nil
      @target_url = options[:target_url] || ProjectRazor::DEFAULT_TARGET
      @target_url = sanitize_url(@target_url)
      @trace_key = options[:trace_key] || nil
      @auth_token = options[:auth_token] || nil
      @user = nil
      @proxy_user = nil

      raise ProjectRazor::Client::Exception::BadParams, "Invalid ProjectRazor API URL: " + @target_url unless valid_target_url?
      if @auth_token
        raise ProjectRazor::Client::Exception::AuthError, "Invalid ProjectRazor API authorization token" unless logged_in?
      end
    end

    private

    # Sanitizes an URL.
    #
    # @param [String] url URL to sanitize.
    # @return [String] URL sanitized.
    def sanitize_url(url)
      url = url =~ /^(http|https).*/i ? url : "http://#{url}"
      url = url.gsub(/\/+$/, "")
    end

    # Checks if the target_url is a valid ProjectRazor target.
    #
    # @return [Boolean] Returns true if target_url is a valid ProjectRazor API URL, false otherwise.
    def valid_target_url?
      # return false unless cloud_info = cloud_info()
      # return false unless cloud_info[:name]
      # return false unless cloud_info[:build]
      # return false unless cloud_info[:support]
      # return false unless cloud_info[:version]

      true
    rescue
      false
    end

    # Requires a logged in user.
    #
    # @raise [ProjectRazor::Client::Exception::AuthError] if user is not logged in.
    def require_login
      raise ProjectRazor::Client::Exception::AuthError unless @user || logged_in?
    end
  end
end