http_proxy  ENV['http_proxy'] || nil
https_proxy  ENV['http_proxy'] || nil
no_proxy  ENV['no_proxy'] || nil
verbose_logging true
file_cache_path "#{ENV['HOME']}/.chef/cache"


cookbook_path File.dirname(File.expand_path(__FILE__)) + "/cookbooks"
json_attribs File.dirname(File.expand_path(__FILE__)) + "/node.json"
