module ZenhubRuby
  class Client
    module Api
      def issue_data(repo_name, issue_number)
        get "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}"
      end

      def issue_events(repo_name, issue_number)
        get "/p1/repositories/#{github.repo_id(repo_name)}/issues/#{issue_number}/events"
      end

      def move_issue(repo_name, issue_number, position, options = {})
        params = {}
        params[:position] = position || "top"
        params[:pipeline_id] = options[:pipeline_id] if options.key?(:pipeline_id)

        post "/p1/repositories/#{options[:repo_id] || github.repo_id(repo_name)}/issues/#{issue_number}/moves", params
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

      def repository_releases_data(repo_name)
        get "/p1/repositories/#{github.repo_id(repo_name)}/reports/releases"
      end

      def release_data(release_id)
        get "/p1/reports/release/#{release_id}"
      end

      def release_issues_data(release_id)
        get "/p1/reports/release/#{release_id}/issues"
      end

      # add_issues or remove_issues should contains Hash with the following structure: { repo_id: Number, issue_number: Number }
      def update_release_issues(release_id, add_issues = [], remove_issues = [])
        patch "/p1/reports/release/#{release_id}/issues",
              { add_issues: add_issues, remove_issues: remove_issues }
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
