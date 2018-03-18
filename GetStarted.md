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








