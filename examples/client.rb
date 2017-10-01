require 'niftycloud'

nc = Niftycloud.client(endpoint: 'https://gitlab.com/api/v4')

nc.issues(4257453).each do |i|
  puts i.title
end




