Add ActiveRecord style find_by and find_all_by to your Mongoid.

---
From your Gemfile:

    gem('mongoid-find_by', require: 'mongoid/finders/find_by')

---
Example:

    class MyModel
      include Mongoid::Document

      field :f1, type: String, default: 'Hello'
      field :f2, type: String, default: 'World'
    end

    MyModel.create!({ f1: 'Hello', f2: 'World' }, without_protection: true)
    MyModel.find_by_f1_and_f2('Hello', 'World')
    #=> #<MyModel _id: 501a6f6071d7f13750000001, _type: nil, f1: "Hello", f2: "World">
