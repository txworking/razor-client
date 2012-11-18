require "project_razor/constants"
require "project_razor/client/requset"
require "project_razor/utility"
require "project_razor/logging"

module ProjectRazor
	class Client
		module Active_model
			ACTIVE_MODEL_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::ACTIVE_MODEL

			def get_all_active_models
				get(ACTIVE_MODEL_URL_PREFIX)
			end

			def get_active_model_by_uuid(active_model_uuid)
				get(ACTIVE_MODEL_URL_PREFIX + '/' + active_model_uuid)
			end

			def get_active_model_logs
				
			end

			def remove_all_active_models
				
			end

			def remove_active_model_by_uuid(active_model_uuid)
				delete(ACTIVE_MODEL_URL_PREFIX + '/' + active_model_uuid)
			end

			def get_logview
				
			end
		end
	end
end

