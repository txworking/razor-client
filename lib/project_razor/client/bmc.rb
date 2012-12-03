require "project_razor/constants"
require "project_razor/client/request"
require "project_razor/utility"
require "project_razor/logging"

module ProjectRazor
	class Client
		module Bmc
			BMC_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::BMC_PATH

			def get_all_bmcs
				get(BMC_URL_PREFIX)	
			end

			def get_bmc_by_uuid(bmc_uuid, options)
				if options[:query]
					get("#{BMC_URL_PREFIX}/#{bmc_uuid}?query=#{options[:query]}")
				else 
					get("#{BMC_URL_PREFIX}/#{bmc_uuid}")
				end
			end

			def update_bmc_power_state
								
			end

			def register_bmc(options)
				json_hash = url_encode(options)
				post("#{BMC_URL_PREFIX}/register/json_hash=#{json_hash}")
			end

		end
	end
end
