class Niftycloud::Client
  module Instances
    def DescribeInstances(options={})
      options[:Action] = 'DescribeInstances'
      get('/', query: options)
    end
  end
end
