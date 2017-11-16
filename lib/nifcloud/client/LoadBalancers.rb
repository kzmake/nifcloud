class Nifcloud::Client
  module LoadBalancers
    def ConfigureHealthCheck(options={})
      options[:Action] = 'ConfigureHealthCheck'
      get('/', query: options)
    end

    def CreateLoadBalancer(options={})
      options[:Action] = 'CreateLoadBalancer'
      get('/', query: options)
    end

    def DeleteLoadBalancer(options={})
      options[:Action] = 'DeleteLoadBalancer'
      get('/', query: options)
    end

    def DeregisterInstancesFromLoadBalancer(options={})
      options[:Action] = 'DeregisterInstancesFromLoadBalancer'
      get('/', query: options)
    end

    def DescribeInstanceHealth(options={})
      options[:Action] = 'DescribeInstanceHealth'
      get('/', query: options)
    end

    def DescribeLoadBalancers(options={})
      options[:Action] = 'DescribeLoadBalancers'
      get('/', query: options)
    end

    def RegisterInstancesWithLoadBalancer(options={})
      options[:Action] = 'RegisterInstancesWithLoadBalancer'
      get('/', query: options)
    end

    def RegisterPortWithLoadBalancer(options={})
      options[:Action] = 'RegisterPortWithLoadBalancer'
      get('/', query: options)
    end

    def SetFilterForLoadBalancer(options={})
      options[:Action] = 'SetFilterForLoadBalancer'
      get('/', query: options)
    end

    def UpdateLoadBalancer(options={})
      options[:Action] = 'UpdateLoadBalancer'
      get('/', query: options)
    end

    def UpdateLoadBalancerOption(options={})
      options[:Action] = 'UpdateLoadBalancerOption'
      get('/', query: options)
    end
  end
end
