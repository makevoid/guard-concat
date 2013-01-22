# Guard::Concat

This little guard allows you to concatenate js/css (or other) files in one.


## Install

Make sure you have [guard](http://github.com/guard/guard) installed.

Install the gem with:

    gem install guard-concat

Or add it to your Gemfile:

    gem 'guard-concat'

And then add a basic setup to your Guardfile:

    guard init concat


## Usage


``` ruby
# This will concatenate the javascript files a.js and b.js in public/js to all.js
guard :concat, type: "js", files: %w(b a), input_dir: "public/js", output: "public/js/all"

# analog css example
guard :concat, type: "css", files: %w(c d), input_dir: "public/css", output: "public/css/all"
```