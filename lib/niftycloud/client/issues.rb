class Niftycloud::Client
  module Issues

    def issues(project=nil, options={})
      if project.to_s.empty? && project.to_i.zero?
        get("/issues", query: options)
      else
        get("/projects/#{url_encode project}/issues", query: options)
      end
    end

    def issue(project, id)
      get("/projects/#{url_encode project}/issues/#{id}")
    end

    def create_issue(project, title, options={})
      body = { title: title }.merge(options)
      post("/projects/#{url_encode project}/issues", body: body)
    end

    def edit_issue(project, id, options={})
      put("/projects/#{url_encode project}/issues/#{id}", body: options)
    end

    def close_issue(project, id)
      put("/projects/#{url_encode project}/issues/#{id}", body: { state_event: 'close' })
    end

    def reopen_issue(project, id)
      put("/projects/#{url_encode project}/issues/#{id}", body: { state_event: 'reopen' })
    end

    def subscribe_to_issue(project, id)
      post("/projects/#{url_encode project}/issues/#{id}/subscribe")
    end

    def unsubscribe_from_issue(project, id)
      post("/projects/#{url_encode project}/issues/#{id}/unsubscribe")
    end

    def delete_issue(project, id)
      delete("/projects/#{url_encode project}/issues/#{id}")
    end

    def move_issue(project, id, options={})
      post("/projects/#{url_encode project}/issues/#{id}/move", body: options)
    end
  end
end