# Mongoid-Find_By

[![Build Status](https://travis-ci.org/envygeeks/mongoid-find_by.png?branch=master)](https://travis-ci.org/envygeeks/mongoid-find_by) [![Coverage Status](https://coveralls.io/repos/envygeeks/mongoid-find_by/badge.png?branch=master)](https://coveralls.io/r/envygeeks/mongoid-find_by) [![Code Climate](https://codeclimate.com/github/envygeeks/mongoid-find_by.png)](https://codeclimate.com/github/envygeeks/mongoid-find_by) [![Dependency Status](https://gemnasium.com/envygeeks/mongoid-find_by.png)](https://gemnasium.com/envygeeks/mongoid-find_by)

Add ActiveRecord style find_by and find_all_by to your Mongoid.

## Installation

```ruby
gem "mongoid-find_by"
```

## Usage

```ruby
class MyModel
  include Mongoid::Document
  field :f1, :type => String, :default => "Hello"
  field :f2, :type => String, :default => "World"
end

MyModel.create!({ f1: "Hello", f2: "World" }, {
  :without_protection => true
})

MyModel.find_by_f1_and_f2("Hello", "World")
#=> #<MyModel _id: 501a6f6071d7f13750000001, _type: nil, f1: "Hello", f2: "World">
```
