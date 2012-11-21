require "project_razor/constants"
require "project_razor/client/requset"
require "project_razor/utility"
require "project_razor/logging"


module ProjectRazor
	class Client
		module	Model
			MODEL_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::MODEL_PATH

			def get_all_models
				get(MODEL_URL_PREFIX)				
			end

			def get_model_by_uuid(model_uuid)
				get(MODEL_URL_PREFIX + '/' + model_uuid)
			end

			def add_model(options)
			  	json_hash = url_encode options
			 	logger.debug MODEL_URI_PREFIX  + "?json_hash=#{json_hash}"
				post(MODEL_URL_PREFIX + "?json_hash=#{json_hash}")
			end

			def update_model(options)
			  	json_hash = url_encode options
			 	logger.debug MODEL_URI_PREFIX  + "?json_hash=#{json_hash}"
				put(MODEL_URL_PREFIX + "?json_hash=#{json_hash}")
			end

			def remove_all_models
				delete(MODEL_URL_PREFIX)				
			end

			def remove_model_by_uuid(model_uuid)
				delet(MODEL_URL_PREFIX + '/' + model_uuid)
			end
			# not supported via REST by razor now
			def get_all_templates
				
			end

		end
	end
end