module Enabler
  class Config
    include Singleton

    attr_accessor :store

    def rule(feature, &block)
      rules << Rule.new(feature.to_sym, block)
    end

    def persistence(val)
      self.store = val
    end

    def after_enabling(feature, &block)
      after_enablings[feature.to_sym] = block
    end

    def after_disabling(feature, &block)
      after_disablings[feature.to_sym] = block
    end

    def rules
      @rules ||= []
    end

    def after_enablings
      @after_enablings ||= {}
    end

    def after_disablings
      @after_disablings ||= {}
    end
  end
end
