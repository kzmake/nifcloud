class Nifcloud::Client
  module Images
    def DescribeImages(options={})
      options[:Action] = 'DescribeImages'
      get('/', query: options)
    end
  end
end
