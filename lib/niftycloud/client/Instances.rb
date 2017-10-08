class Niftycloud::Client
  module Instances
    def Instances(options={})
      options[:Action] = 'DescribeInstances'
      get('/', query: options)
    end
  end
end
