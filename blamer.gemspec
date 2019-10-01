lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = 'blamer'
  s.version = '4.1.1'
  s.authors = ['Keith Morrison']
  s.email = 'keithm@infused.org'
  s.homepage = 'http://github.com/infused/blame'
  s.summary = 'Userstamps for ActiveRecord'
  s.description = 'Automatically userstamps create and update operations if the table has created_by and/or updated_by columns'
  s.license = 'MIT'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.files = Dir['[A-Z]*', '{lib,test}/**/*', 'blame.gemspec']
  s.test_files = Dir.glob('test/**/*_test.rb')
  s.require_paths = ['lib']

  s.required_rubygems_version = '>= 1.3.0'
  s.add_dependency 'activerecord'
end
