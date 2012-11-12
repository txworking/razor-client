require 'project_razor/client/request'
require 'project_razor/constants'

module ProjectRazor
	class Client
		module Policy
		 POLICY_URI_PREFIX = @target_url + ProjectRazor::POLICY_PATH
			def get_all_policies
			  get(POLICY_URI_PREFIX)
			end
			def get_policy_by_uuid(policy_uuid)
			  get(POLICY_URI_PREFIX + policy_uuid)
		end
	end
end