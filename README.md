# Blamer

[![Version](http://img.shields.io/gem/v/blamer.svg?style=flat)](https://rubygems.org/gems/blamer)
[![Build Status](http://img.shields.io/travis/infused/blamer/master.svg?style=flat)](http://travis-ci.org/infused/blamer)
[![Code Quality](http://img.shields.io/codeclimate/maintainability/infused/blamer.svg?style=flat)](https://codeclimate.com/github/infused/blamer)
[![Total Downloads](https://img.shields.io/gem/dt/blamer.svg)](https://rubygems.org/gems/blamer/)
[![License](https://img.shields.io/github/license/infused/blamer.svg)](https://github.com/infused/blamer)

Automatically userstamps create and update operations if the table has columns named **created_by** and/or **updated_by**.
The Blamer gem attempts to mirror the simplicity of ActiveRecord's timestamp module.

Blamer expects `User.current_user` to return the current user object. Basic setup involves assigning to `User.current_user` in a controller before filter:

    class User < ActiveRecord::Base
      cattr_accessor :current_user
    end

    class ApplicationController < ActionController::Base
      before_action :set_userstamp

      def set_userstamp
        User.current_user = User.find(session[:user_id])
      end
    end

If you don't want to use `User.current_user` you can override this behavior by writing your own `userstamp_object` method in ActiveRecord::Base or any of your models. For example, to use `Person.current` instead:

    def userstamp_object
      Person.current
    end

If you don't like created_by/updated_by you can customize the column names:

    # Globally in environment.rb
    ActiveRecord::Base.created_userstamp_column = :creator_id
    ActiveRecord::Base.updated_userstamp_column = :updator_id

    # In a model definition
    class Subscription
      self.created_userstamp_column = :creator_id
      self.updated_userstamp_column = :updater_id
    end

Automatic userstamping can be turned off globally by setting:

    ActiveRecord::Base.record_userstamps = false

Blamer adds a `userstamps` migration helper which will add the created_by and updated_by columns (or your custom column names) to your table:

    create_table :widgets do |t|
      t.string :name
      t.timestamps
      t.userstamps
    end

## Thread Safety

If you need thread safety make sure that your implementation of `User.current_user` (or your custom user object) is thread safe.  Here's one way this can be accomplished:

    class User < ActiveRecord::Base
      def self.current_user
        Thread.current[:current_user]
      end

      def self.current_user=(user)
        Thread.current[:current_user] = user
      end
    end

## Compatability

Blamer is tested to be compatible with Rails 2.x, 3.x, 4.x, and 5.x. See version specific Installation
instructions below.

## Installation

You must use the correct version of blamer for the version of Rails you are running:

### Rails 4 and Rails 5

Add to your Gemfile

    gem 'blamer'

Or

    gem 'blamer', github: 'infused/blamer'

### Rails 3.x

Add to your Gemfile

    gem 'blamer', '~> 3.0.0'

Or

    gem 'blamer', :github => 'infused/blamer', :branch => '3_stable'

### Rails 2.x

Add a line to your environment.rb

    config.gem 'blamer', '~> 3.0.0'

## Credits

Thanks to DeLynn Berry <delynn@gmail.com> for writing the original Userstamp plugin
(http://github.com/delynn/userstamp/), which was the inspiration for this plugin.

## License

Copyright (c) 2008-2018 Keith Morrison <<keithm@infused.org>>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
