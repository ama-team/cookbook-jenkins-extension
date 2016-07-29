property :id, String, name_property: true
property :domain, String, required: false

def get_group_path(group)
  ::File.join(
      node['jenkins_x']['templated_jobs_workspace'],
      "#{group.domain.index}-#{group.domain.id}",
      "#{group.index}-#{group.id}"
  )
end

action :create do
  unless domain
    domain = node['jenkins_x']['default_job_group_domain']
  end
  # noinspection RubyScope
  unless JenkinsX::Job::REGISTRY.has_group(domain, id)
    group = JenkinsX::Job::REGISTRY.group(domain, id)
    directory get_group_path(group) do
      recursive true
      action :create
    end
  end
end

action :delete do
  unless domain
    domain = node['jenkins_x']['default_job_group_domain']
  end
  # noinspection RubyScope
  if JenkinsX::Job::REGISTRY.has_group(domain, id)
    group = JenkinsX::Job::REGISTRY.group(domain, id)
    directory get_group_path(group) do
      recursive true
      action :delete
    end
    # todo verify that removal doesn't misbehave because of two-phase application
    JenkinsX::Job::REGISTRY.remove_group(domain, id)
  end
end