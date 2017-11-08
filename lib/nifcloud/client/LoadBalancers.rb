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
  end
end
