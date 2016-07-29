default['jenkins_x']['workspace'] = ::File.join(Chef::Config[:file_cache_path], 'jenkins-x')
default['jenkins_x']['templated_dsl_jobs_workspace'] = ::File.join(Chef::Config[:file_cache_path], 'jenkins-x', 'templated-dsl-jobs')
default['jenkins_x']['templated_jobs_workspace'] = ::File.join(Chef::Config[:file_cache_path], 'jenkins-x', 'templated-jobs')
default['jenkins_x']['scripts_workspace'] = ::File.join(Chef::Config[:file_cache_path], 'jenkins-x', 'scripts')
default['jenkins_x']['default_job_group_domain'] = 'chef-dsl-applier'