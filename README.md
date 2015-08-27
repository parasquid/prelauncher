## Guard

This project uses guard, guard-rspec and guard-rails. In your terminal:

    $ guard

and it will show something like the following:

    11:41:13 - INFO - Guard::RSpec is running
    11:41:13 - INFO - [Guard::Rails] will start the default web server on port 3000 in development.
    11:41:13 - INFO - Starting Rails...

    => Booting WEBrick
    => Rails 4.2.4 application starting in development on http://localhost:3000
    => Run `rails server -h` for more startup options
    => Ctrl-C to shutdown server
    [2015-08-27 11:41:15] INFO  WEBrick 1.3.1
    [2015-08-27 11:41:15] INFO  ruby 2.1.5 (2014-11-13) [x86_64-linux]
    [2015-08-27 11:41:15] INFO  WEBrick::HTTPServer#start: pid=17599 port=3000
    11:41:16 - INFO - Rails started, pid 17599

    11:41:16 - INFO - Guard is now watching at '/home/user/prelauncher'

it will automatically start a rails development server you can visit at ` http://localhost:3000` as well as watch your files for changes and automatically run tests against them.
