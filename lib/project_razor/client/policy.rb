require 'project_razor/client/request'
require 'project_razor/constants'
require 'project_razor/utility'
require 'json'
require 'erb'

module ProjectRazor
	class Client
		module Policy
		 POLICY_URI_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::POLICY_PATH
			include ProjectRazor::Utility
			def get_all_policies
			  	get(POLICY_URI_PREFIX)
			end
			
			def get_policy_by_uuid(policy_uuid)
			  	get(POLICY_URI_PREFIX + '/' +	policy_uuid)
			end

			def add_policy(options)
			  	#parse options to URI format	
			  	json_hash = url_encode(options)
			 	logger.debug POLICY_URI_PREFIX  + "?json_hash=#{json_hash}"
			 	post(POLICY_URI_PREFIX  + "?json_hash=#{json_hash}")
			end

			def update_policy(policy_uuid,options)
			  	json_hash = url_encode(options)
				logger.debug POLICY_URI_PREFIX + '/' + policy_uuid + "?json_hash=#{json_hash}"
				put(POLICY_URI_PREFIX + '/' + policy_uuid + "?json_hash=#{json_hash}")
			end

			def remove_all_policies
				delete(POLICY_URI_PREFIX)
			end

			def remove_policy_by_uuid(policy_uuid)
				delete(POLICY_URI_PREFIX + '/' + policy_uuid)
			end

			def get_policy_template
				get(POLICY_URI_PREFIX + '/templates')				
			end
		end
	end
end