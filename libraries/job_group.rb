module JenkinsX
  module Job
    class Group

      attr_reader :id
      attr_reader :index
      attr_reader :domain
      attr_reader :entry_index

      def initialize(id, index, domain)
        @id = id
        @index = index
        @domain = domain
        @entry_index = '000'
      end

      def next_entry_index
        @entry_index.next!
      end
    end

    class GroupDomain

      attr_reader :id
      attr_reader :index

      def initialize(id, index)
        @id = id
        @index = index
        @groups = {}
        @counter = '000'
      end

      def group(group_id)
        unless @groups[group_id]
          @groups[group_id] = Group.new(group_id, @counter.next!, self)
        end
        @groups[group_id]
      end

      def has_group?(group_id)
        @groups.key?(group_id)
      end

      def remove_group(group_id)
        @groups.delete(group_id)
      end

      def groups
        @groups.values
      end
    end

    class GroupRegistry

      def initialize
        @domains = {}
        @counter = '000'
      end

      def domain(domain_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)

        unless @domains[domain_id]
          @domains[domain_id] = GroupDomain.new(domain_id, @counter.next!)
        end
        @domains[domain_id]
      end

      def group(domain_id, group_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)
        group_id = JenkinsX::Utility.coerce_to_path_segment(group_id)

        domain(domain_id).group(group_id)
      end

      def remove_domain(domain_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)

        @domains.delete(domain_id)
      end

      def remove_group(domain_id, group_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)
        group_id = JenkinsX::Utility.coerce_to_path_segment(group_id)

        if has_group?(domain_id, group_id)
          domain(domain_id).remove_group(group_id)
        end
      end

      def has_domain?(domain_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)

        @domains.key?(domain_id)
      end

      def has_group?(domain_id, group_id)
        domain_id = JenkinsX::Utility.coerce_to_path_segment(domain_id)
        group_id = JenkinsX::Utility.coerce_to_path_segment(group_id)

        has_domain?(domain_id) and domain(domain_id).has_group?(group_id)
      end

      def domains
        @domains.values
      end

    end

    # todo if this has to be singleton, it should at least be withing resources
    REGISTRY = GroupRegistry.new
  end
end