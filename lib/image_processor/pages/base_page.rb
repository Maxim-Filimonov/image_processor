module ImageProcessor
  module Pages
    class BasePage < ERB
      def initialize(args)
        @template = args.fetch(:template, self.class.template)
        super(@template)
      end

      def result
        super(binding)
      end
      
      def self.template
        File.read(File.expand_path('../../../../data/output-template.erb', __FILE__))
      end
    end
  end
end
