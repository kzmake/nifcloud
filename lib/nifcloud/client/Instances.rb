class Nifcloud::Client
  module Instances
    def DescribeInstances(options={})
      options[:Action] = 'DescribeInstances'
      get('/', query: options)
    end

    def DescribeInstanceAttribute(options={})
      options[:Action] = 'DescribeInstanceAttribute'
      get('/', query: options)
    end

    def ModifyInstanceAttribute(options={})
      options[:Action] = 'ModifyInstanceAttribute'
      get('/', query: options)
    end

    def RebootInstances(options={})
      options[:Action] = 'RebootInstances'
      get('/', query: options)
    end

    def RunInstances(options={})
      options[:Action] = 'RunInstances'
      get('/', query: options)
    end

    def StartInstances(options={})
      options[:Action] = 'StartInstances'
      get('/', query: options)
    end

    def StopInstances(options={})
      options[:Action] = 'StopInstances'
      get('/', query: options)
    end

    def TerminateInstances(options={})
      options[:Action] = 'TerminateInstances'
      get('/', query: options)
    end
  end
end
