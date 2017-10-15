require 'nifcloud'
require 'pp'

nc = Nifcloud.client(endpoint: 'https://computing.jp-west-1.api.cloud.nifty.com/api', debug: true)
res = nc.DescribeInstances()

pp res

pp res.reservationSet[0].groupSet[0].groupId
pp res.reservationSet[0].instancesSet[0].instanceId
