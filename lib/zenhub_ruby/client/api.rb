module ZenhubRuby
  class Client
    module Api
      def issue_data(repo_name, issue_number)
        get "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}"
      end

      def issue_events(repo_name, issue_number)
        get "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}/events"
      end

      def board_data(repo_name)
        get "/p1/repositories/#{github.repo_id(repo_name)}/board"
      end

      def update_estimate(repo_name, issue_number, estimate)
        put "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}/estimate",
            estimate: estimate
      end

      def issue_move_pipeline(repo_name, issue_number, pipeline_name, position = 'bottom')
        post "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}/moves",
             pipeline_id: pipeline_id(repo_name, pipeline_name),
             position: position
      end

      private

      def pipeline_id(repo_name, pipeline_name)
        pipeline = board_data(repo_name).body['pipelines'].find do |p|
          p['name'] == pipeline_name
        end
        pipeline['id'] unless pipeline.nil?
      end
    end
  end
end
