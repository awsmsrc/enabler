require 'enabler'

describe Enabler::Config do
  let(:processor) { Proc.new { true } }
  subject { Enabler::Config.instance }

  describe "rule" do
    it "adds the rule" do
      expect { 
        subject.rule :dance, &processor 
      }.to change { 
        subject.rules.length 
      }.from(0).to 1
    end
  end

  describe "after_enabling" do
    before { subject.after_enabling :dance, &processor }
    specify { subject.after_enablings[:dance].should == processor }
  end

  describe "after_disabling" do
    before { subject.after_enabling :dance, &processor }
    specify { subject.after_disablings[:dance].should == processor }
  end
end

