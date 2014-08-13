module Homeflow
  module API
    class Message < Resource

      is_resource :messages

      def self.create(params)
        Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
      end

    end
  end
end