---
title: "A custom application configuration solution for Ruby on Rails"
date: 2010-08-06
comments: true
tags: coding
gist: sukima/510438:load_config.rb
---
I found this great [RailsCast][1] about making a global configuration. However
I wanted to further customize it by allowing global configurations regardless
of the environment.

For example this is the original idea:

```yaml
# config/config.yml
development:
  perform_authentication: false

test:
  perform_authentication: false

production:
  perform_authentication: true
  username: admin
  password: secret
```

This would require that there be a lot of repetition. What I wanted was a way
to write a global variable once and still keep differences for the
environments. I eventually thought of this solution to manipulate the hash
after the fact (avoiding the warnings that a constant variable being changed).

Instead I want to make it more like:

```yaml
global_var1: "foo"
global_var2: "bar"
environments:
  development:
    env_var: "foobar"
  test:
    env_var: "barfoo"
```

This will produce the following config when `RAILS_ENV` is development:

```ruby
APP_CONFIG['global_var1']    #=> "foo"
APP_CONFIG['global_var2']    #=> "bar"
APP_CONFIG['env_var']        #=> "foobar"
```

Here is the code:

gist: sukima/510438:load_config.rb

In a rails application you can put `load_config.rb` into `config/initializers`
directory.

[1]: http://railscasts.com/episodes/85-yaml-configuration-file
