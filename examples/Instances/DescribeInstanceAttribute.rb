require 'nifcloud'
require 'pp'

nc = Nifcloud.client(endpoint: 'https://computing.jp-west-1.api.cloud.nifty.com/api', debug: true)
res = nc.DescribeInstanceAttribute(InstanceId: 'test')

pp res

pp res.InstanceId
