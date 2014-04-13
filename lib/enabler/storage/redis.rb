module Enabler
	module Storage
		class Redis

			attr_reader(:redis)

			def initialize(redis)
				@redis = redis
			end

			def add!(feature, model)
				redis.sadd key(feature, model), model.id
			end

			def remove!(feature, model)
				redis.srem key(feature, model), model.id
			end

			def enabled?(feature, model)
				redis.sismember key(feature, model), model.id 
			end

			private

			def key(feature, model)
				"enabler::#{underscore model.class.to_s}::#{underscore feature.to_s}"
			end

			#taking from active support
			def underscore(string)
				string.gsub(/::/, '/').
					gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
					gsub(/([a-z\d])([A-Z])/,'\1_\2').
					tr("-", "_").
					downcase
			end

		end
	end
end
