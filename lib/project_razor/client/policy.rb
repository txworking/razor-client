require 'project_razor/client/request'
require 'project_razor/constants'

module ProjectRazor
	class Client
		module Policy
			def get_all_policies
			  get(@target_url + ProjectRazor::POLICY_PATH)
			end
		end
	end
end