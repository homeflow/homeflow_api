module Homeflow
  module API
    class Notification < Resource

      is_resource :notifications

      def self.create(params)
        Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
      end

    end
  end
end