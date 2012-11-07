module CloudFoundry
  class Client
    # CloudFoundry API Applications methods.
    module Policy
      # Returns the list of applications deployed on the target cloud.
      #
      # @return [Hash] List of applications deployed on the target cloud.
      # @authenticated True
      def list_policies()
        get(Razor::Client::POLICY_PATH)
      end
     end
   end
end