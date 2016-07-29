property :source, String, name_property: true
property :cookbook, String, required: false
property :variables, Hash, default: {}
property :sensitive, [TrueClass, FalseClass], default: true
property :auto_clean, [TrueClass, FalseClass], default: true

# todo shouldn't there be more gallant way to create directory only once?
first_run = true

action :execute do

  id = SecureRandom.uuid
  script_path = ::File.join(node['jenkins_x']['workspace'], 'scripts', 'script-' + id)

  if first_run
    directory_path = ::File.dirname(script_path)
    directory_resource = directory directory_path do
      recursive true
      action :create
    end
  end

  template_resource = template "Script '#{name}' template" do
    path script_path
    cookbook cookbook
    sensitive new_resource.sensitive
    variables new_resource.variables
  end

  jenkins_script "Script '#{name}'" do
    command lazy { ::File.read(script_path) }
    if new_resource.auto_clean
      notifies :delete, template_resource, :immediate
    end
  end

  if first_run
    ruby_block 'script directory removal notifier' do
      block { }
      notifies :delete, directory_resource, :delayed
    end
  end
  first_run = false
end