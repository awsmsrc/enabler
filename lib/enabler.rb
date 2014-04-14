require "enabler/version"
require "enabler/storage/redis"
require "enabler/errors/rule_already_defined_error"
require "enabler/rule"

module Enabler

  def self.store=(val)
    @@store = val
  end
  
  def self.store
    @@store
  end
  
  def self.enabled?(feature, object)
    enabled_via_rule?(feature, object) || enabled_via_storage?(feature, object)
  end
  
  def self.enabled_via_storage?(feature, object)
    store.enabled?(feature, object)
  end
  
  def self.enabled_via_rule?(feature, object)
    sym = feature.to_sym
    r = self.rule(sym)
    return false unless r
    r.enabled?(object)
  end
  
  def self.enable!(feature, object)
    store.add!(feature, object)
  end
  
  def self.disable!(feature, object)
    store.remove!(feature, object)
  end
  
  def self.rules
    @@rules ||= [] 
  end
  
  def self.rule(feature)
    self.rules.select { |item| item.feature == feature.to_sym }.first
  end
  
  def self.define_rule!(feature, &block)
    sym = feature.to_sym
    raise Errors::RuleAlreadyDefinedError if self.rule(sym)
    self.rules << Rule.new(sym, block)
  end
end
