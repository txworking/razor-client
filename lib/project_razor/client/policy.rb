require 'project_razor/client/request'
require 'project_razor/constants'
require 'project_razor/utility'
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
			  	json_hash = url_encode options
			 	logger.debug POLICY_URI_PREFIX  + "?json_hash=#{json_hash}"
			 	post(POLICY_URI_PREFIX  + "?json_hash=#{json_hash}")
			end

			def update_policy(options)
			  	json_hash = url_encode options
				logger.debug POLICY_URI_PREFIX + "json_hash=#{josn_hash}"
				put(POLICY_URI_PREFIX + "json_hash=#{josn_hash}")
			end

			def remove_all_policies
				delete(POLICY_URI_PREFIX)
			end

			def remove_policy_by_uuid(policy_uuid)
				delete(POLICY_URI_PREFIX + '/' + policy_uuid)
			end
			# not supported via REST now
			def get_policy_template
				
			end
		end
	end
end