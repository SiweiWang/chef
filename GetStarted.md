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

1. this is a declarative programming style (compare to procedural style)

2. idempotent