class Niftycloud::Client
  module Instances 
    def Instances(options={})
      get("/", query: options)
    end
  end
end