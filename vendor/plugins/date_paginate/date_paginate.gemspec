# encoding: utf-8

require File.expand_path('../lib/date_paginate/version', __FILE__)
Gem::Specification.new do |s|
  s.name    = 'date_paginate'
  s.version = DatePaginate::VERSION::STRING
  
  s.summary = "Pagination plugin for web frameworks and other apps"
  s.description = "Provides a simple API for building pagination based around dates"
  
  s.authors  = ['Dominic Wroblewski']
  s.email    = 'dominic@terracoding.com'
  s.homepage = 'http://github.com'
  
  s.rdoc_options = ['--main', 'README.md', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  
  s.files = Dir['Rakefile', '{bin,lib,test,spec}/**/*', 'README*', 'LICENSE*']

  # include only files in version control
  git_dir = File.expand_path('../.git', __FILE__)
  void = defined?(File::NULL) ? File::NULL :
    RbConfig::CONFIG['host_os'] =~ /msdos|mswin|djgpp|mingw/ ? 'NUL' : '/dev/null'

  if File.directory?(git_dir) and system "git --version >>#{void} 2>&1"
    s.files &= `git --git-dir='#{git_dir}' ls-files -z`.split("\0") 
  end
end