module Enabler
  class Rule
    attr_reader :feature, :definition

    def initialize(feature, definition)
      @feature = feature
      @definition = definition
    end

    def enabled?(model)
      definition.call(model)
    end

    def self.find(feature)
      ::Enabler.config.rules.select { |item| item.feature == feature.to_sym }
    end
  end
end
