require "project_razor/constants"
require "project_razor/client/request"
require "project_razor/utility"
require "project_razor/logging"

module ProjectRazor
	class Client
		module Node
			NODE_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::NODE_PATH

			def get_all_nodes
				get(NODE_URL_PREFIX)
			end

			def get_node_by_uuid(node_uuid)
				get("#{NODE_URL_PREFIX}/#{node_uuid}")
			end

			def get_node_attributes(node_uuid)
				get("#{NODE_URL_PREFIX}/#{node_uuid}?field=attributes")
			end

			def get_node_hardware_ids(node_uuid)
				get("#{NODE_URL_PREFIX}/#{node_uuid}?field=hardware_ids")
			end
		end
	end
end
