describe Fastlane::Actions::CustomAwsS3Action do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The custom_aws_s3 plugin is working!")

      Fastlane::Actions::CustomAwsS3Action.run(nil)
    end
  end
end
