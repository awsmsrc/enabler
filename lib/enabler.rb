require "singleton"
require "enabler/version"

require "enabler/config"
require "enabler/storage/redis"
require "enabler/errors/rule_already_defined_error"
require "enabler/rule"

module Enabler
  class << self 

    def store
      config.store
    end

    def enable!(feature, object)
      store.add!(feature, object)
      config.after_enablings[feature].call(object) if config.after_enablings[feature]
    end

    def disable!(feature, object)
      store.remove!(feature, object)
      config.after_disablings[feature].call(object) if config.after_disablings[feature]
    end

    def enabled?(feature, object)
      enabled_via_rule?(feature, object) || enabled_via_storage?(feature, object)
    end

    def all_manually_enabled(feature, object_class)
      store.all_enabled(feature, object_class.new)
    end

    def config
      Enabler::Config.instance
    end

    def configure(&block)
      config.instance_eval &block
    end

    private

    def enabled_via_storage?(feature, object)
      store.enabled?(feature, object)
    end

    def enabled_via_rule?(feature, object)
      Array(Rule.find(feature.to_sym)).map do |r| 
        r.enabled? object 
      end.include? true
    end

  end
end
