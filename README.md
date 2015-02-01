# Blamer

[![Version](http://img.shields.io/gem/v/blamer.svg?style=flat)](https://rubygems.org/gems/blamer)
[![Build Status](http://img.shields.io/travis/infused/blamer/master.svg?style=flat)](http://travis-ci.org/infused/blamer)
[![Code Quality](http://img.shields.io/codeclimate/github/infused/blamer.svg?style=flat)](https://codeclimate.com/github/infused/blamer)

Automatically userstamps create and update operations if the table has columns named *created_by* and/or *updated_by*.
The Blamer gem attempts to mirror the simplicity of ActiveRecord's timestamp module.

Blamer expects User.current_user to return the current user. Basic setup involves assigning to `User.current_user` in a controller before filter:

    class User < ActiveRecord::Base
      cattr_accessor :current_user
    end

    class ApplicationController < ActionController::Base
      before_filter :set_userstamp

      def set_userstamp
        User.current_user = User.find(session[:user_id])
      end
    end

If you don't want to use `User.current_user` you can override this behavior by writing your own *userstamp_object* method in ActiveRecord::Base or any of your models. For example, to use Person.current:

    def userstamp_object
      Person.current
    end

If you don't like created_by/updated_by you can customize the column names:

    # Globally in environment.rb
    ActiveRecord::Base.created_userstamp_column = :creator_id

    # In a model definition
    class Subscription
      self.created_userstamp_column = :creator_id
      self.updated_userstamp_column = :updater_id
    end

Automatic userstamping can be turned off globally by setting:

    ActiveRecord::Base.record_userstamps = false

Blamer adds a *userstamps* migration helper which will add the created_by and updated_by columns (or your custom column names) to your table:

    create_table :widgets do |t|
      t.string :name
      t.timestamps
      t.userstamps
    end


## Installation


### Rails 2.x

Add a line to your environment.rb

    config.gem 'blamer', '~> 2.0.0'

### Rails 3.x

Add to your Gemfile

    gem 'blamer', '~> 3.0.0'

Or

    gem 'blamer', :github => 'infused/blame', :branch => '3_stable'

### Rails 4.x

Add to your Gemfile

    gem 'blamer', '~> 4.0.0'

Or

gem 'blamer', :github => 'infused/blame', :branch => '4_stable'


## Credit

Thanks to DeLynn Berry <delynn@gmail.com> for writing the original Userstamp plugin
(http://github.com/delynn/userstamp/), which was the inspiration for this plugin.


## License

Copyright (c) 2008-2015 Keith Morrison <<keithm@infused.org>>

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
