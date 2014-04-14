module Enabler
  class Rule

    attr_reader :feature, :definition

    def initialize(feature, definition)
      @feature, @definition = feature, definition
    end

    def enabled?(model)
      definition.call(model)
    end

  end
end
