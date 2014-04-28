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
		context "with after callbacks" do
			before do
				model.stub(:stubbed).and_return true
				Enabler.configure do
					after_enabling :dance do |object|
						object.stubbed
					end
				end
			end
			it "calls the after_enabling callback" do
				model.stub :stubbed
				model.should_receive :stubbed
				Enabler.enable! :dance, model
			end
		end
	end

	describe ".disable!" do
		it "calls set on the store" do
			store.should_receive(:remove!).with(:dance, model)
			Enabler.disable! :dance, model
		end
	end

	describe "rules" do
		context "with no rules set" do
			specify { Enabler.config.rules.should be == [] }
		end

		context "with rules set" do
			before do
				Enabler.configure do
					rule :boogie do 
						true
					end
				end
			end
			after do
				Enabler.class_variable_set(:@@rules, [])
			end
      
			specify { Enabler.config.rules.length.should be == 1 }
			specify { Enabler::Rule.find(:boogie).first.feature.should == :boogie }
			specify { Enabler::Rule.find(:boogie).first.definition.call.should be_true }
		end
	end
end
