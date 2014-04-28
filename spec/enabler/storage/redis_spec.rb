require 'mock_redis'
require 'enabler'

describe Enabler::Storage::Redis do
  let(:redis) { MockRedis.new }
  let(:model) { double('Model', id:1, class:'Model') }
  subject { Enabler::Storage::Redis.new(redis) }

  describe "#add!" do
    it "adds the id to the correct set in redis" do
      expect{ 
        subject.add!(:dance, model) 
      }.to change{
        redis.sismember('enabler::model::dance', 1) 
      }.from(false).to(true)
    end
  end

  describe "#remove!" do
    before { subject.add!(:dance, model)	}
    it "removes the id from the correct set in redis" do
      expect{ 
        subject.remove!(:dance, model) 
      }.to change{
        redis.sismember('enabler::model::dance', 1) 
      }.from(true).to(false)
    end
  end


  describe "#enabled?" do
    context "when id is in set" do
      before { subject.add!(:dance, model) }
      specify { subject.enabled?(:dance, model).should be_true }
    end
    context "when id is not in set" do
      specify { subject.enabled?(:dance, model).should be_false }
    end
  end
end
