require 'project_razor/client/request'
require 'project_razor/constants'
require 'json'
require 'erb'

module ProjectRazor
	class Client
		module Policy
		 POLICY_URI_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::POLICY_PATH
			
			def get_all_policies
			  get(POLICY_URI_PREFIX)
			end
			
			def get_policy_by_uuid(policy_uuid)
			  get(POLICY_URI_PREFIX + '/' +	policy_uuid)
			end

			def add_policy(options)
			  #parse options to URI format	
				json_str  = JSON.dump(options)
				json_hash = ERB::Util.url_encode(json_str)
			  logger.debug POLICY_URI_PREFIX  + "?json_hash=#{json_hash}"
			  post(POLICY_URI_PREFIX  + "?json_hash=#{json_hash}")
			end
		end
	end
end