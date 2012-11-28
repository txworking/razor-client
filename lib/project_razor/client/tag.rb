require "project_razor/constants"
require "project_razor/client/request"
require "project_razor/utility"
require "project_razor/logging"


module ProjectRazor
	class Client
		TAG_URL_PREFIX = ProjectRazor::DEFAULT_TARGET + ProjectRazor::TAG_PATH

		module Tag
			def get_all_tagrules
				get(TAG_URL_PREFIX)
			end

			def get_tagrule_by_uuid(tag_uuid)
				get("#{TAG_URL_PREFIX}/#{tag_uuid}")
			end

			def add_tagrule(options)
				json_hash = url_encode(options)
				post("#{TAG_URL_PREFIX}?json_hash=#{json_hash}")
			end

			def update_tagrule(tag_uuid, options)
				json_hash = url_encode(options)
				put("#{TAG_URL_PREFIX}/#{tag_uuid}?json_hash=#{json_hash}")
			end

			def remove_all_tagrules
				delete("#{TAG_URL_PREFIX}")
			end

			def remove_tagrule_by_uuid(tag_uuid)
				delete("#{TAG_URL_PREFIX}/#{tag_uuid}")
			end

			def get_matcher_by_uuid(tag_uuid, matcher_uuid)
				get("#{TAG_URL_PREFIX}/#{tag_uuid}/matcher/#{matcher_uuid}")
			end

			def add_matcher(tag_uuid, options)
				json_hash = url_encode(options)
				post("#{TAG_URL_PREFIX}/#{tag_uuid}/matcher?json_hash=#{json_hash}")				
			end

			def update_matcher(tag_uuid, matcher_uuid, options)
				json_hash = url_encode(options)
				put("#{TAG_URL_PREFIX}/#{tag_uuid}/matcher/#{matcher_uuid}?json_hash=#{json_hash}")
			end

			def remove_matcher(tag_uuid, matcher_uuid)
				delete("#{TAG_URL_PREFIX}/#{tag_uuid}/matcher/#{matcher_uuid}")
			end
		end
	end
end
