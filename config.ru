require 'rubygems'
require 'bundler/setup'
require 'rack/request'
require 'rack/rewrite'
require 'rack/contrib/try_static'

use Rack::Deflater
# also, look into Rack::ETag

use Rack::TryStatic, :root => "_site", :urls => %w[/], :try => ['.html', 'index.html', '/index.html']

# Serve the 404 error page
error_file = '_site/404.html'
run lambda { |env| [404, {
  'Last-Modified'  => File.mtime(error_file).httpdate,
  'Content-Type'   => 'text/html' ,
  'Content-Length' => File.size(error_file).to_s },[ File.read(error_file)] ]
}
