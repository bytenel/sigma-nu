if  ENV['MAILCHIMP_API_KEY'].nil?
 ENV['MAILCHIMP_API_KEY'] = YAML.load(ERB.new(File.read("#{::Rails.root}/config/secret/gibbon.yml")).result)[::Rails.env]['MAILCHIMP_API_KEY']
end

Gibbon::Export.api_key = ENV["MAILCHIMP_API_KEY"]
Gibbon::Export.timeout = 15
Gibbon::Export.throws_exceptions = false