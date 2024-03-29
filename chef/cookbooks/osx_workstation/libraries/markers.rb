class Chef::Recipe
  
  #Regarding marker files:
  #
  #The idea here is you have a simple "signal" on disk that tells you when you've
  #successfully run something, and you don't want to run it again if you don't have to.
  #
  #Also, the decision to rerun a unit of work becomes explicit - and owned by you.
  #(it's not based on trusting a target program to respond in some way).
  #You don't have to learn and keep up this "re-run" logic per unit of work / program
  #
  #Also, simply ls'ing the marker dir gives you interesting information all in once place -
  #i.e. what markers are there and what are their timestamps?
  #
  #And reinstalls are easy - just rm the relevant marker file.

  def run_unless_marker_file_exists(marker_file_name)
    marker_dir = "#{WS_HOME}/.install_markers"
    directory marker_dir do
      owner WS_USER
      group WS_USER
      recursive true
    end

    marker_path = File.join(marker_dir, marker_file_name)
    if File.exists?(marker_path)
      log "skipping #{marker_file_name}: marker file found (#{marker_path}), detail: #{`ls -la #{marker_path}`.strip}"
    else

      log "no marker file found for #{marker_file_name} in #{marker_dir}, running"

      yield

      execute "touching marker file #{marker_path} after successful run" do
        user ws_user
        command "touch #{marker_path}"
      end

    end 
  end 
end
