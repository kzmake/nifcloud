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
  end
end
