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
    end
  end
end
