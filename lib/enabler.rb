require "enabler/version"
require "enabler/storage/redis"

module Enabler

	def self.store=(val)
		@@store = val
	end

	def self.store
		@@store
	end

	def self.enabled?(feature, object)
		store.enabled?(feature, object)
	end

	def self.enable!(feature, object)
		store.add!(feature, object)
	end

	def self.disable!(feature, object)
		store.remove!(feature, object)
	end

end
