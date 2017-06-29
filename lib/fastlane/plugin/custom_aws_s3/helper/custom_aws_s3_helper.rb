module Fastlane
  module Helper
    class CustomAwsS3Helper
      # class methods that you define here become available in your action
      # as `Helper::CustomAwsS3Helper.your_method`
      #
      def self.show_message
        UI.message("Hello from the custom_aws_s3 plugin helper!")
      end
    end
  end
end
