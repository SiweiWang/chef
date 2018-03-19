# Getting started with chef

## Sample chef recipe

```ruby
package "httpd" do
    action :install
end
```

In this example:
1. package is the resource type(Linux package)
1. httpd is the name of the package to act on
1. action is to install the package

Two of priciples in chef

1. declarative programming style (compare to procedural style): Sepecify the end state, without sepecify how to get there

2. idempotent: unchanged in value when multiple or otherwise operated on by itself


## Type of Chef

1. Hosted chef 
- Fully cloud hosted SaaS
- Easy to setup
- Very limited customization options
- No control over access speeds
2. Chef Server
- Installed on-premises or cloud IaaS
- More complex installation
- Allows fine-grained control
- Enables rapid deployment/update

## Chef Componets
### Chef server
1. Management console
- optional
2. HA and Federation is availiable (paid)
3. Analystics platform

### Chef client node
Can be either On permises or Cloud node

### Chef DK
Chef DK workstation is the locaiton where user interact with Chef. User author and test cookbookls using tools such as Test Kitchen
- Cookbook and policy authoring
- Test-driven infrastructure

## Install Chef in centos

### install chef server and chef dk
See the shell script [here](VagrantProvision/provision.sh)

### verfiy installation

#### verify chef dk ssl
```bash
knife ssl check
```
If the cert is self-signed, make sure you trust the CA by using

```bash
knife ssl fetch
```

#### verify chef server
```bash
chef verify
```

## Chef DK commands

### Create new cookbook
To create a cookbook, first go to the cookbooks dir under chef-repo and run 
```bash
chef generate cookbook lab
```

### Create new recipe
find the new cookbook lab and add a new .rb file name apache.rb with content
```ruby
package "httpd" do
    action :install
end
```

this example will make sure chef installs apache http server.

### List cookbooks
```bash
knife cookbook list
```

### Upload cookbooks
```bash
knife cookbook upload --all
```

will upload all the cookbooks

### List roles
```bash
knife role list
```

### Update roles
``` bash
knife role from file <role_file>
```

### List nodes
```bash
knife node list
```

### Add new node using Chef DK
knife bootstrap <chef_node_hostname> --ssh-user <ssh_username> --ssh-password <ssh_password> --node-name linux-client --sudo --verbose

### Show node run list
```bash
knife node show linux-client
```

### add node run list 
knife node run_list add <node_name> "<role_name>"

## Chef client commad

### Run cookbook
sudo chef-client

## Berkshelf
Berkshelf is a dependency manager for Chef cookbooks. With it, you can easily depend on community cookbooks and have them safely included in your workflow. You can also ensure that your CI systems reproducibly select the same cookbook versions, and can upload and bundle cookbook dependencies without needing a locally maintained copy. Berkshelf is included in the Chef Development Kit.

Example: edit the metadata.rb in on of the cookbook that requires apt

```ruby
name 'my_first_cookbook'
version '0.1.0'
depends 'apt', '~> 5.0'
```

To install apt cookbook, run
```bash
berks install
```

To upload to Chef server, with dependencies, run
```bash
berks upload
```


## Secret management -- databag

### create a databag
```bash
knife data bag create credentials
```

### add credentials with encryption key
```bash
knife data bag from file credentials ./data_bags/credentials/sql_server_root_password.json --secret-file encrypted_data_bag_secret
```

### Show encrypted password
```bash
knife data bag show credentials sql_server_root_password
```

sample output
```
WARNING: Encrypted data bag detected, but no secret provided for decoding. Displaying encrypted data.
id:       sql_server_root_password
password:
  auth_tag:       PD9lk/5KRH4nn+FA16Fj5w==

  cipher:         aes-256-gcm
  encrypted_data: cLwlWuYlu7z7KKvvsKNri+Grmk6hKYZtcoNyUU4=

  iv:             n83LN4l9Jp/DX1hq

  version:        3
```

### Show plain text password
```bash
knife data bag show credentials sql_server_root_password --secret-file encrypted_data_bag_secret
```

sample output
```
Encrypted data bag detected, decrypting with provided secret.
id:       sql_server_root_password
password: DevOpsPlus
```