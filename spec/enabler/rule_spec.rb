require 'enabler'

describe Enabler::Rule do
  let(:model) { double('Model', id: 1) }
  let(:pass_rule_def) { proc { |model| model.id == 1 } }
  let(:fail_rule_def) { proc { |model| model.id != 1 } }

  context 'with a passing rule' do
    subject { Enabler::Rule.new(:jump, pass_rule_def) }
    specify { subject.enabled?(model).should be_true }
  end

  context 'with a failing rule' do
    subject { Enabler::Rule.new(:jump, fail_rule_def) }
    specify { subject.enabled?(model).should be_false }
  end
end
