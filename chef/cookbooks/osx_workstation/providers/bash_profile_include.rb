
action :create do
  sc_user = ENV['USER']
  sc_user_home = ENV['HOME'] 
  bash_includes_dirname = ".bash_profile_includes"
  bash_include_subdir = ::File.expand_path("#{sc_user_home}/#{bash_includes_dirname}")
  Chef::Log.debug(" user is #{node['user']}")
  directory bash_include_subdir do
    owner sc_user
    group sc_user
  end
  
  template "#{sc_user_home}/.bash_profile" do
    source "bash_profile.erb"
    owner sc_user
    group sc_user
    variables ({:bash_includes_dirname => bash_includes_dirname})
  end

  template "#{bash_include_subdir}/#{new_resource.name}.sh" do
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner sc_user
    group sc_user
    mode "0755"
  end
end
