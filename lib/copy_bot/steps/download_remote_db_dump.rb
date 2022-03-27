module CopyBot
  module Steps
    class DownloadRemoteDbDump < BaseStep
      # @return [String]
      def run
        return @message = 'Missing S3 credentials in config' unless s3_credentials

        @success = source_object.download_file(destination_file_path)
        @message = @success ? successful_download_message : 'Remote DB dump download failed.'
      end

      private

      def s3_credentials
        step_definition[:s3_credentials]
      end

      def source_object
        s3_resource.bucket(s3_credentials[:bucket]).object(source_file_path)
      end

      def s3_resource
        Aws::S3::Resource.new(client: s3_client)
      end

      def s3_client
        Aws::S3::Client.new(region: s3_credentials[:region], credentials: aws_credentials)
      end

      def aws_credentials
        Aws::Credentials.new(s3_credentials[:access_key_id], s3_credentials[:access_key])
      end

      def successful_download_message
        "s3://#{s3_credentials[:bucket]}/#{source_file_path} has been downloaded to #{destination_file_path}"
      end

      def source_file_path
        step_definition[:source_file_path]
      end

      def destination_file_path
        step_definition[:destination_file_path]
      end
    end
  end
end
