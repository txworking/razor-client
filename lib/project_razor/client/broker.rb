require "project_razor/constants"
require "project_razor/client/request"
require "project_razor/utility"
require "project_razor/logging"

module ProjectRazor
	class Client
		module Broker
			BROKER_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::BROKER_PATH

			def get_all_brokers
				get(BROKER_URL_PREFIX)
			end

			def get_broker_by_uuid(borker_uuid)
				get("#{BROKER_URL_PREFIX}/#{broker_uuid}")
			end

			def get_broker_plugins
				get("#{BROKER_URL_PREFIX}/#{ProjectRazor::PLUGINS}")				
			end

			def add_broker(options)
				json_hash = url_encode(options)
				logger.debug "add broker:#{BROKER_URL_PREFIX}?json_hash=#{json_hash}"
				post("#{BROKER_URL_PREFIX}?json_hash=#{json_hash}"
			end

			def update_broker(borker_uuid, options)
				json_hash = url_encode(options)
				logger.debug "update broker:#{BROKER_URL_PREFIX}?json_hash=#{json_hash}"
				put("#{BROKER_URL_PREFIX}/#{broker_uuid}?json_hash=#{json_hash}"
			end

			def remove_all_brokers
				delete("#{BROKER_URL_PREFIX}/#{ProjectRazor::ALL}")
			end

			def remove_broker_by_uuid(broker_uuid)
				delete("#{MODEL_URL_PREFIX}/#{borker_uuid}")
			end

		end
	end
end
