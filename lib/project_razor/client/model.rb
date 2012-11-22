require "project_razor/constants"
require "project_razor/client/request"
require "project_razor/utility"
require "project_razor/logging"


module ProjectRazor
	class Client
		module	Model
			MODEL_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::MODEL_PATH
			include ProjectRazor::Utility
			def get_all_models
			  	get(MODEL_URL_PREFIX)
			end
			
			def get_model_by_uuid(model_uuid)
			  	get("#{MODEL_URL_PREFIX}/#{model_uuid}")
			end

			def add_model(options)
			  	#parse options to URI format	
			  	json_hash = url_encode(options)
			 	logger.debug "add model:#{MODEL_URL_PREFIX}?json_hash=#{json_hash}"
			 	post("#{MODEL_URL_PREFIX}?json_hash=#{json_hash}")
			end

			def update_model(model_uuid,options)
			  	json_hash = url_encode(options)
				logger.debug "update model:#{MODEL_URL_PREFIX}/#{model_uuid}?json_hash=#{json_hash}"
				put("#{MODEL_URL_PREFIX}/#{model_uuid}?json_hash=#{json_hash}")
			end

			def remove_all_models
				delete("#{MODEL_URL_PREFIX}/#{ProjectRazor::ALL}")
			end

			def remove_model_by_uuid(model_uuid)
				logger.debug  "delete model:#{MODEL_URL_PREFIX}/#{model_uuid}"
				delete("#{MODEL_URL_PREFIX}/#{model_uuid}")
			end

			def get_model_templates
				get("#{MODEL_URL_PREFIX}/#{ProjectRazor::TEMPLATES}")				
			end

		end
	end
end