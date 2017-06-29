module Fastlane
  module Actions
    module SharedValues
      CUSTOM_AWS_S3_URL = :CUSTOM_AWS_S3_URL
    end
    class CustomAwsS3Action < Action
      def self.run(params)

        require 'aws-sdk'
        
        aws_akid = params[:aws_akid]
        aws_secret = params[:aws_secret]
        aws_region = params[:aws_region]
        aws_bucket = params[:aws_bucket]
        aws_key = params[:aws_key]
        file = params[:file]

        
        Aws.config.update({
            region: aws_region,
            credentials: Aws::Credentials.new('AKIAJBQ4YEID2DAYWYQQ', 'TJ2RoE2v4GUBPLxAc1yPfmF8k8gStiF5I4+9uLqz')
        })

        s3 = Aws::S3::Resource.new(region:aws_region)        
        obj = s3.bucket(aws_bucket).object(aws_key)
        UI.message("Uploading file to #{aws_bucket} with key #{aws_key}")        
        obj.upload_file(file)
        UI.message("#{file} Uploaded!")
        UI.message("Updating latest uploaded file")
        obj = s3.bucket(aws_bucket).object("latest.zip")
        obj.upload_file(file)
        UI.message("Latest uploaded!")        
        s3_client = Aws::S3::Client.new        
        signer = Aws::S3::Presigner.new({client: s3_client})
        url = signer.presigned_url(:get_object, bucket: aws_bucket, key: aws_key, expires_in: 604800)
        UI.message("#{url} Created!")                        

        return Actions.lane_context[SharedValues::CUSTOM_AWS_S3_URL] = url        
      end

      def self.description
        "Upload custom file to s3 and get the signed url"
      end

      def self.authors
        ["Daniel Mendez"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "WIP"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :aws_akid,
                              short_option: "-a",          
                                  env_name: "CUSTOM_AWS_S3_ACCESS_KEY",
                               description: "AWS access key",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :aws_secret,
                              short_option: "-s",          
                                  env_name: "CUSTOM_AWS_S3_SECRET",
                               description: "AWS secret",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :aws_bucket,
                              short_option: "-b",          
                                  env_name: "CUSTOM_AWS_S3_BUCKET",
                               description: "AWS S3 bucket name",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :aws_region,
                              short_option: "-r",          
                                  env_name: "CUSTOM_AWS_S3_REGION",
                                description: "AWS S3 Region",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :aws_key,
                              short_option: "-k",          
                                  env_name: "CUSTOM_AWS_S3_KEY",
                                description: "AWS S3 Key",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :file,
                              short_option: "-f",          
                                  env_name: "CUSTOM_AWS_S3_FILE",
                                description: "file to upload",
                                  optional: false,
                                      type: String),             
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
