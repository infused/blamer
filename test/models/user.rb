class User < ActiveRecord::Base
  cattr_accessor :current_user
end