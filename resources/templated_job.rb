property :job_id, String, name_property: true
property :source, String, required: true
property :cookbook, String, required: false
property :sensitive, [TrueClass, FalseClass], default: true
property :variables, Hash, default: {}
property :auto_clean, [TrueClass, FalseClass], default: true
property :path, String, required: false

property :parameters, Hash, default: {}
property :stream_job_output, [TrueClass, FalseClass], default: true
property :wait_for_completion, [TrueClass, FalseClass], default: true

# todo helpers

action :create do
  resolved_path = path
  unless resolved_path
    normalized_id = JenkinsX::Utility.coerce_to_path_segment(job_id)
    resolved_path = ::File.join(node['jenkins_x']['templated_jobs_workspace'], normalized_id)
  end

  directory_path = ::File.dirname(resolved_path)
  directory directory_path do
    recursive true
    not_if { ::File.exists(directory_path) }
  end

  template "templated job #{name}" do
    source new_resource.source
    path resolved_path
    cookbook new_resource.cookbook
    sensitive new_resource.sensitive
    variables new_resource.variables
  end

  jenkins_job job_id do
    action :create
    config resolved_path
  end

  if auto_clean
    file "templated job #{name} deletion" do
      path resolved_path
      action :delete
    end
  end
end

action :delete do
  jenkins_job job_id do
    action :delete
  end
end

action :build do
  jenkins_job job_id do
    action :build
    parameters new_resource.parameters
    stream_job_output new_resource.stream_job_output
    wait_for_completion new_resource.wait_for_completion
  end
end

action :disable do
  jenkins_job job_id do
    action :disable
  end
end

action :enable do
  jenkins_job job_id do
    action :enable
  end
end