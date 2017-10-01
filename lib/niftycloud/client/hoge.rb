class Niftycloud::Client
  module Hoge
    def hoge(id=nil, options={})
      if id.to_s.empty? && id.to_i.zero?
        get("/issues", query: options)
      else
        get("/projects/#{url_encode id}/issues", query: options)
    end
    end
  end
end