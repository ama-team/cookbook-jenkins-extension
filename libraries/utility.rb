module JenkinsX
  module Utility
    def coerce_to_path_segment(string)
      string.lower.gsub('_', '-').gsub(/[^a-z0-9\-\.]/, '.')
    end

    def job_group_domain_path(root, domain)
      ::File.join(root, "#{domain.index}-#{domain.id}")
    end

    def job_group_path(root, group)
      ::File.join(job_group_domain_path(root, group.domain), "#{group.index}-#{group.id}")
    end

    def extract_job_domain_steps(root, domain)
      path = job_group_domain_path(root, domain)
      mask = ::File.join(path, '*', '*')
      Dir.glob(mask)
    end
  end
end