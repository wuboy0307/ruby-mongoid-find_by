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

  it "raises NoMethodError if the method doesn't start with find_by" do
    expect_error NoMethodError do
      FindByModel.hello_world
    end
  end

  it "accepts find_all_by" do
    output = cmodel.find_all_by_hello("world")
    expect(output.count).to eq 2
    output.each do |v|
      expect(v).to be_kind_of FindByModel
    end
  end

  it "accepts multiple fields on find_all_by" do
    output = cmodel.find_all_by_hello_and_world("world", "hello")
    expect(output.count).to eq 2
    output.each do |v|
      expect(v).to be_kind_of FindByModel
    end
  end

  it "accepts multiple fields on find_by" do
    expect(cmodel.find_by_hello_and_world("world", "hello")).to be_kind_of FindByModel
  end

  it "accepts find_by" do
    expect(cmodel.find_by_hello("world")).to be_kind_of FindByModel
  end

  it "raises NoMethodError if the field doesn't exist" do
    expect_error NoMethodError do
      cmodel.find_by_unknown("value")
    end
  end

  it "caches finder on the class" do
    cmodel.find_by_hello("world")
    expect(cmodel).to respond_to :find_by_hello
  end
end
