# Blame

Automatically userstamps create and update operations if the table has columns named *created_by* and/or *updated_by*.
The Blame plugin attempts to mirror the simplicity of ActiveRecord's timestamp module.

Blame assumes that you are using restful-authentication and expects User.current_user to return the current user. You
can override this behavior by writing your own *userstamp_object* method in ActiveRecord::Base or any of your models. For example:

    def userstamp_object
      User.find(session[:user_id])
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

Blame adds a *userstamps* migration helper which will add the created_by and updated_by columns (or your custom column names) to your table:

    create_table :widgets do |t|
      t.string :name
      t.timestamps
      t.userstamps
    end


## Installation


### Rails 2.x

Add a line to your environment.rb

    config.gem 'blame'


### Rails 3.x +

Add to your Gemfile

    gem 'blame'


## Credit

Thanks to DeLynn Berry <delynn@gmail.com> for writing the original Userstamp plugin
(http://github.com/delynn/userstamp/tree/master), which was the inspiration for this plugin.


## License

Copyright (c) 2008-2014 Keith Morrison <<keithm@infused.org>>

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
