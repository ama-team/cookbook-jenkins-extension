# jenkins-x Cookbook

This cookbook provides extensive functionality for [jenkins][jenkins-cookbook]:
job DSL templating, templated scripts, common scripts and stuff.

## Requirements

Currently this cookbook is only tested manually on ubuntu derivative
distros.

The only dependency is `jenkins` cookbook.

### Platforms

- Ubuntu

### Chef

- Chef 12.0+

### Cookbooks

- `jenkins` - building base for jenkins-x

## Attributes

| Key                          | Type   | Description        | Default |
|------------------------------|--------|--------------------|---------|
| `['jenkins_x']['workspace']` | String | Directory to store intermediate dirty laundry in | `#{Chef::Config[:file_cache_path]}/jenkins-x` |


## Usage

TODO: Write usage instructions for each resource.

### TODO: jenkins_x_templated_script

### TODO: jenkins_x_templated_job_group

### TODO: jenkins_x_templated_job

### TODO: jenkins_x_templated_job_dsl

### TODO: jenkins_x_flush_templated_jobs

### TODO: jenkins_x_password_credentials

### TODO: jenkins_x_ssh_credentials

### TODO: jenkins_x_secret_text_credentials

## Contributing

What would octocat do? 

## License and Authors

Authors: 

- Etki <etki@etki.me>

  [jenkins-cookbook]: https://supermarket.chef.io/cookbooks/jenkins