require "rspec/helper"

describe Mongoid::Finders::FindBy do
  before :all do
    class FindByModel
      include Mongoid::Document

      field :hello, type: String
      field :world, type: String
    end
  end

  let :cmodel do
    Object.send(:const_set, obj = random_class, Class.new(FindByModel))
    obj = Object.const_get(obj)
    obj.create!(hello: "world", world: "hello")
    obj.create!(hello: "world", world: "hello")

    obj
  end

  it "raises NoMethodError if the field doesn't exist" do
    expect { cmodel.find_by_unknown("value") }.to raise_error NoMethodError
  end

  context "without the method starting with find[_all]_by" do
    it "passes to super" do
      expect { FindByModel.hello_world }.to raise_error NoMethodError
    end
  end

  it "caches the finder" do
    cmodel.find_by_hello("world")
    expect(cmodel).to respond_to :find_by_hello
  end

  it "accepts find_by" do
    expect(cmodel.find_by_hello("world")).to be_kind_of FindByModel
  end

  it "accepts find_all_by" do
    output = cmodel.find_all_by_hello("world")
    expect(output.count).to eq 2
    output.each do |v|
      expect(v).to be_kind_of FindByModel
    end
  end

  context "multiple fields" do
    it "accepts on find_all_by" do
      output = cmodel.find_all_by_hello_and_world("world", "hello")
      expect(output.count).to eq 2
      output.each do |v|
        expect(v).to be_kind_of FindByModel
      end
    end

    it "accepts on find_by" do
      result = cmodel.find_by_hello_and_world("world", "hello")
      expect(result).to be_kind_of FindByModel
    end
  end
end
