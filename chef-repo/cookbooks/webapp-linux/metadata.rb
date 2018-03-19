name 'webapp-linux'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures webapp-linux'
long_description 'Installs/Configures webapp-linux'
version '0.2.3'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/webapp-linux/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/webapp-linux'

depends 'yum', '~> 5.1.0'
depends 'httpd', '~> 0.6.2'
depends 'firewall', '~> 2.6.3'

depends 'mysql2_chef_gem', '~> 2.1.0'
depends 'mysql', '~> 8.5.1'
depends 'database', '~> 4.0.9'

