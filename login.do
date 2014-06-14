#!/usr/bin/ruby
# -*- encoding: utf-8 -*-
#
# login.do - a small honey pot system. 
#
# usage?
#   $ sudo apt-get install ruby
#   $ cd /var/www/html
#   $ git clone https://github.com/yoggy/login.do.git
#   $ cd login.do
#   $ chown +x login.do
#   $ sudo touch log.json && sudo chown www-data:www-data log.json
#   
require 'cgi'
require 'json'

logfile = 'log.json'

print "Content-type: text/html\n\n"

env_keys = %w(REMOTE_ADDR REMOTE_PORT REQUEST_METHOD HTTP_USER_AGENT)

cgi = CGI.new
json = {}
json["_t"]     = Time.now.to_i
env_keys.each do |k|
  json[k] = ENV[k] if ENV.key?(k)
end
json["params"] = cgi.params

open(logfile, "a") do |f|
  f.puts JSON.generate(json)
end

print <<-EOS
<html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="refresh" content="5; URL=index.html">

    <title>maintenance console</title>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.c
ss">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

   <div class="container">
      <div class="row">
        <div class="col-md-4">
          <h2>login failed...</h2>
          <p>please check email or password</p>
        </div>
      </div>
    </div>
  </body>
</html>
EOS
