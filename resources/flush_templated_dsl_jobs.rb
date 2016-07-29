property :domain, String, required: false

action :execute do
  unless domain
    domain = node['jenkins_x']['default_job_group_domain']
  end
  if JenkinsX::Job::REGISTRY.has_domain?(domain)
    domain_instance = JenkinsX::Job::REGISTRY.domain(domain)
    root = default['jenkins_x']['templated_dsl_jobs_workspace']
    path = JenkinsX::Utility.job_group_domain_path(root, domain_instance)
    jenkins_x_templated_job domain_instance.id do
      source 'dsl-application-job.xml.erb'
      variables lazy {
        {
            steps: JenkinsX::Utility.extract_job_domain_steps(root, domain_instance)
        }
      }
      action [:create, :build]
    end

    directory path do
      recursive true
      action :delete
    end
  end
end