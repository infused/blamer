Blame
=====

Automatically userstamps create and update operations if the table has fields named created_by and/or updated_by.

Blame adds a `userstamps` migration helper which will create both created_by and updated_by columns to your table:

      create_table :widgets do |t|
        t.string :name
        t.timestamps
        t.userstamps
      end

Blame defaults to looking for the current user in User.current_user, but you can override this behavior by writing your own userstamp_object method in ActiveRecord::Base or any of your models:

      def userstamp_object
        User.current_user # the default
        Superduper.superman
      end

Automatic userstamping can be turned off by setting

    ActiveRecord::Base.record_userstamps = false
  
  
Installation
============

    ruby script/plugin install git://github.com/infused/blame.git
  

Credit
======

Thanks to DeLynn Berry <delynn@gmail.com> for writing the original Userstamp plugin (http://github.com/delynn/userstamp/tree/master), which I've used in many project over the last several years.  Unfortunately, its grown too complex and hard to keep up to date with Rails releases for my tastes.  The Blame plugin attempts to mirror the simplicity of ActiveRecord's timestamp module.
  

Copyright (c) 2008 Keith Morrison <keithm@infused.org>, released under the MIT license
