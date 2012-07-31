require 'spec_helper'

describe Mongoid::Finders::FindBy do
  before :all do
    class FindByModel
      include Mongoid::Document

      field :f1, type: Fixnum
      field :f2, type: Fixnum
      field :f3, type: Fixnum

      attr_accessible :f1, :f2, :f3
    end
  end

  let(:model) { FindByModel }
  let :clean_model do
    Object.send(:const_set, obj = Mongoid::SpecHelpers.random_class, Class.new(model))
    obj = Object.const_get(obj)

    obj.create!(f1: 1, f2: 2, f3: 3)
    obj.create!(f1: 1, f2: 2, f3: 3)
    obj.create!(f1: 1, f2: 2, f3: 3)

    obj
  end

  subject { model }

  context '"after include"' do
    describe 'Model.method_missing' do
      it 'should call super if the missing method does not begin with find_by(_all)?' do
        expect { model.send(Mongoid::SpecHelpers.random(10)) }.to raise_error(NoMethodError)
        expect { model.send(Mongoid::SpecHelpers.random(10)) }.to raise_error(NoMethodError)
        expect { model.send(Mongoid::SpecHelpers.random(10)) }.to raise_error(NoMethodError)
      end

      it 'should define find_by_* if the field exists' do
        clean_model.find_by_f1(1).should be_kind_of(clean_model)
        clean_model.find_by_f2(2).should be_kind_of(clean_model)
        clean_model.find_by_f3(3).should be_kind_of(clean_model)

        clean_model.methods.should include(:find_by_f1)
        clean_model.methods.should include(:find_by_f2)
        clean_model.methods.should include(:find_by_f3)
      end

      it 'should not define find_by_* if the field does not exist' do
        expect { model.find_by_f4(4) }.to raise_error(NoMethodError)
        expect { model.find_by_f5(5) }.to raise_error(NoMethodError)
        expect { model.find_by_f6(6) }.to raise_error(NoMethodError)

        model.methods.should_not include(:find_by_f4)
        model.methods.should_not include(:find_by_f5)
        model.methods.should_not include(:find_by_f6)
      end

      it 'should define find_by_*_and_* with unlimited _and_* if all the fields exist' do
        clean_model.find_by_f1_and_f2(1, 2).should be_kind_of(clean_model)
        clean_model.find_by_f2_and_f3(2, 3).should be_kind_of(clean_model)
        clean_model.find_by_f1_and_f3(1, 3).should be_kind_of(clean_model)
        clean_model.find_by_f1_and_f2_and_f3(1, 2, 3).should be_kind_of(clean_model)

        clean_model.methods.should include(:find_by_f1_and_f2)
        clean_model.methods.should include(:find_by_f1_and_f3)
        clean_model.methods.should include(:find_by_f2_and_f3)
        clean_model.methods.should include(:find_by_f1_and_f2_and_f3)
      end

      it 'should not define find_by_*_and_* with unlimited _and_* if all fields do not exist' do
        expect { model.find_by_f1_and_f4(1, 4) }.to raise_error(NoMethodError)
        expect { model.find_by_f2_and_f4(2, 4) }.to raise_error(NoMethodError)
        expect { model.find_by_f3_and_f4(3, 4) }.to raise_error(NoMethodError)
        expect { model.find_by_f1_and_f2_and_f3_and_f4(1, 2, 3, 4) }.to raise_error(NoMethodError)

        model.methods.should_not include(:find_by_f1_and_f4)
        model.methods.should_not include(:find_by_f2_and_f4)
        model.methods.should_not include(:find_by_f3_and_f4)
        model.methods.should_not include(:find_by_f1_and_f2_and_f3_and_f4)
      end

      it 'should define find_all_by_* if the field exists' do
        clean_model.find_all_by_f1(1).should have(3).items
        clean_model.find_all_by_f2(2).should have(3).items
        clean_model.find_all_by_f3(3).should have(3).items

        clean_model.methods.should include(:find_all_by_f1)
        clean_model.methods.should include(:find_all_by_f2)
        clean_model.methods.should include(:find_all_by_f3)
      end

      it 'should not define find_all_by_* if the fields do not exist' do
        expect { model.find_all_by_f4(4) }.to raise_error(NoMethodError)
        expect { model.find_all_by_f5(5) }.to raise_error(NoMethodError)
        expect { model.find_all_by_f6(6) }.to raise_error(NoMethodError)

        model.methods.should_not include(:find_all_by_f4)
        model.methods.should_not include(:find_all_by_f5)
        model.methods.should_not include(:find_all_by_f6)
      end

      it 'should define find_all_by_*_and_* with unlimited _and_* if all fields exist' do
        clean_model.find_all_by_f1_and_f2(1, 2).should have(3).items
        clean_model.find_all_by_f1_and_f3(1, 3).should have(3).items
        clean_model.find_all_by_f2_and_f3(2, 3).should have(3).items
        clean_model.find_all_by_f1_and_f2_and_f3(1, 2, 3).should have(3).items

        clean_model.methods.should include(:find_all_by_f1_and_f2)
        clean_model.methods.should include(:find_all_by_f1_and_f3)
        clean_model.methods.should include(:find_all_by_f2_and_f3)
        clean_model.methods.should include(:find_all_by_f1_and_f2_and_f3)
      end

      it 'should not define find_all_by_* with unlimited _and_* if all fields do not exist' do
        expect { model.find_all_by_f1_and_f4(1, 4) }.to raise_error(NoMethodError)
        expect { model.find_all_by_f2_and_f4(2, 4) }.to raise_error(NoMethodError)
        expect { model.find_all_by_f3_and_f4(3, 4) }.to raise_error(NoMethodError)
        expect { model.find_all_by_f1_and_f2_and_f3_and_f4(1, 2, 3, 4) }.to raise_error(NoMethodError)

        model.methods.should_not include(:find_all_by_f1_and_f4)
        model.methods.should_not include(:find_all_by_f2_and_f4)
        model.methods.should_not include(:find_all_by_f3_and_f4)
        model.methods.should_not include(:find_all_by_f1_and_f2_and_f3_and_f4)
      end
    end
  end
end
