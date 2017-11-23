class Nifcloud::Client
  module ElasticLoadBalancers
    def NiftyConfigureElasticLoadBalancerHealthCheck(options={})
      options[:Action] = 'NiftyConfigureElasticLoadBalancerHealthCheck'
      get('/', query: options)
    end
  end
end
