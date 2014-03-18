if  ENV['S3_ACCESS_KEY_ID'].nil? 
 ENV['S3_ACCESS_KEY_ID'] = YAML.load(ERB.new(File.read("#{::Rails.root}/config/secret/s3.yml")).result)[::Rails.env]['S3_ACCESS_KEY_ID']
end

if  ENV['S3_SECRET_ACCESS_KEY'].nil?
 ENV['S3_SECRET_ACCESS_KEY']= YAML.load(ERB.new(File.read("#{::Rails.root}/config/secret/s3.yml")).result)[::Rails.env]['S3_SECRET_ACCESS_KEY']
end