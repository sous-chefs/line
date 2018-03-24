require 'tempfile'

class LineCookbook
  class HackyFileProvider < Chef::Provider::File
    provides :hacky_file

    class HackyContent < Chef::FileContentManagement::ContentBase
      def file_for_provider
        new_resource.injected_tempfile
      end
    end

    def initialize(new_resource, run_context)
      @content_class = HackyContent
      super
    end
  end

  class HackyFileResource < Chef::Resource::File
    resource_name :hacky_file
    provides :hacky_file

    property :injected_tempfile, Tempfile
  end
end
