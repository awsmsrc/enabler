require 'enabler'

describe Enabler do
	let(:store) { double('Store', add!:true, remove!:true) }
	let(:model) { double('Model', id:1, class:'Model') }
	before { Enabler.store = store }

	describe ".enabled?" do

		context "when store has feature enabled" do
			before { store.stub(:enabled?) { true } }
			specify { Enabler.enabled?(:dance, model).should be_true }
		end

		context "when store has feature disabled" do
			before { store.stub(:enabled?) { false } }
			specify { Enabler.enabled?(:dance, model).should be_false }
		end

	end

	describe ".enable!" do
		it "calls set on the store" do
			store.should_receive(:add!).with(:dance, model)
			Enabler.enable! :dance, model
		end
	end

	describe ".disable!" do
		it "calls set on the store" do
			store.should_receive(:remove!).with(:dance, model)
			Enabler.disable! :dance, model
		end
	end
end
