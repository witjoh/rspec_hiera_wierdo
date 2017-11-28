# Solved !!!

It was a stupid error in my hiera.yaml. (red cheeks mode ...)
I got:
``` yaml
---
:backends:
  - yaml
:yaml:
  :datadir: './spec/fixtures/hiera/hieradata'
  :hierarchy:
    - "%{fqdn}"
    - 'something'
```
This way, the hierarchy is aprt of the :yaml:block, and as such not recognzed by hiera.  The correct version:
```
---
:backends:
  - yaml
:yaml:
  :datadir: './spec/fixtures/hiera/hieradata'
:hierarchy:
  - "%{fqdn}"
  - 'something'
```
Just leave this for reference....

# hierarchy from hiera.yaml is not respected

[root@docker my_notify]# bundle exec rake spec
Could not find semantic_puppet gem, falling back to internal functionality. Version checks may be less robust.
I, [2017-11-27T21:21:18.968044 #13617]  INFO -- : Creating symlink from spec/fixtures/modules/my_notify to /root/my_notify
/usr/local/rvm/rubies/ruby-2.1.9/bin/ruby -I/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/lib:/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-support-3.7.0/lib /usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/exe/rspec --pattern spec/\{aliases,classes,defines,unit,functions,hosts,integration,type_aliases,types\}/\*\*/\*_spec.rb --color

my_notify
  testing hiera
Warning: Accessing 'modulepath' as a setting is deprecated. See http://links.puppetlabs.com/env-settings-deprecations
   (at /usr/local/rvm/gems/ruby-2.1.9/gems/puppet-3.8.7/lib/puppet/settings.rb:1137:in `issue_deprecation_warning')
Debug: Caching environment 'production' (ttl = 0 sec)
Debug: Evicting cache entry for environment 'production'
Debug: Caching environment 'rp_env' (ttl = 0 sec)
Warning: The use of 'import' is deprecated at 3. See http://links.puppetlabs.com/puppet-import-deprecation
   (at /usr/local/rvm/gems/ruby-2.1.9/gems/puppet-3.8.7/lib/puppet/parser/parser_support.rb:110:in `import')
Debug: importing '/root/my_notify/spec/fixtures/manifests/site.pp' in environment rp_env
Debug: importing '/root/my_notify/spec/fixtures/modules/my_notify/manifests/init.pp' in environment rp_env
Debug: Automatically imported my_notify from my_notify into rp_env
Debug: hiera(): Hiera YAML backend starting
Debug: hiera(): Looking up foo_message in YAML backend
Debug: hiera(): Looking for data source common
Debug: hiera(): Found foo_message in common
Notice: Compiled catalog for docker.vagrant.vdab.be in environment rp_env in 0.14 seconds
    should contain Notify[foo] with message => "from something" (FAILED - 1)

Failures:

  1) my_notify testing hiera should contain Notify[foo] with message => "from something"
     Failure/Error:
       is_expected.to contain_notify('foo').with ({
         'message' => 'from something',
       })
     
       expected that the catalogue would contain Notify[foo] with message set to "from something" but it is set to "from common"
     # ./spec/classes/my_notify_spec.rb:33:in `block (3 levels) in <top (required)>'

Finished in 0.25769 seconds (files took 0.70772 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/classes/my_notify_spec.rb:32 # my_notify testing hiera should contain Notify[foo] with message => "from something"

/usr/local/rvm/rubies/ruby-2.1.9/bin/ruby -I/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/lib:/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-support-3.7.0/lib /usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/exe/rspec --pattern spec/\{aliases,classes,defines,unit,functions,hosts,integration,type_aliases,types\}/\*\*/\*_spec.rb --color failed


[root@docker my_notify]# export PUPPET_GEM_VERSION='~> 4'
[root@docker my_notify]# bundle update
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies......


[root@docker my_notify]# bundle exec rake spec
Could not find semantic_puppet gem, falling back to internal functionality. Version checks may be less robust.
I, [2017-11-27T21:28:22.621919 #13717]  INFO -- : Creating symlink from spec/fixtures/modules/my_notify to /root/my_notify
/usr/local/rvm/rubies/ruby-2.1.9/bin/ruby -I/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/lib:/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-support-3.7.0/lib /usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/exe/rspec --pattern spec/\{aliases,classes,defines,unit,functions,hosts,integration,type_aliases,types\}/\*\*/\*_spec.rb --color

my_notify
  testing hiera
Warning: ModuleLoader: module 'my_notify' has unresolved dependencies - it will only see those that are resolved. Use 'puppet module list --tree' to see information about modules
   (file & line not available)
Warning: The function 'hiera' is deprecated in favor of using 'lookup'. See https://docs.puppet.com/puppet/4.10/reference/deprecated_language.html
   (file & line not available)
Warning: /root/my_notify/spec/fixtures/hiera/hiera.yaml: Use of 'hiera.yaml' version 3 is deprecated. It should be converted to version 5
   (in /root/my_notify/spec/fixtures/hiera/hiera.yaml)
Notice: Compiled catalog for docker.vagrant.vdab.be in environment rp_env in 0.16 seconds
    should contain Notify[foo] with message => "from something" (FAILED - 1)

Failures:

  1) my_notify testing hiera should contain Notify[foo] with message => "from something"
     Failure/Error:
       is_expected.to contain_notify('foo').with ({
         'message' => 'from something',
       })
     
       expected that the catalogue would contain Notify[foo] with message set to "from something" but it is set to "from common"
     # ./spec/classes/my_notify_spec.rb:33:in `block (3 levels) in <top (required)>'

Finished in 0.33519 seconds (files took 1.26 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/classes/my_notify_spec.rb:32 # my_notify testing hiera should contain Notify[foo] with message => "from something"

/usr/local/rvm/rubies/ruby-2.1.9/bin/ruby -I/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/lib:/usr/local/rvm/gems/ruby-2.1.9/gems/rspec-support-3.7.0/lib /usr/local/rvm/gems/ruby-2.1.9/gems/rspec-core-3.7.0/exe/rspec --pattern spec/\{aliases,classes,defines,unit,functions,hosts,integration,type_aliases,types\}/\*\*/\*_spec.rb --color failed



[root@docker my_notify]# bundle exec hiera -d -c spec/fixtures/hiera/hiera.yaml foo_message fqdn=test.example.com
DEBUG: 2017-11-27 21:49:28 +0000: Hiera YAML backend starting
DEBUG: 2017-11-27 21:49:28 +0000: Looking up foo_message in YAML backend
DEBUG: 2017-11-27 21:49:28 +0000: Ignoring bad definition in :hierarchy: 'nodes/'
DEBUG: 2017-11-27 21:49:28 +0000: Looking for data source common
DEBUG: 2017-11-27 21:49:28 +0000: Found foo_message in common
from common

