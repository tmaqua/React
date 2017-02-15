namespace :rpush do
  task :environment do
  end

  desc 'Restart rpush'
  task :restart_rpush do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          if test('[ -f /var/www/rails/FeelingCall/shared/tmp/pids/rpush.pid ]')
            puts "Rpush is running"
            execute :bundle, :exec, "rpush stop -e #{fetch(:rails_env)}"
            execute :bundle, :exec, "rpush start -e #{fetch(:rails_env)}"
          else
            puts "Rpush is not running"
            execute :bundle, :exec, "rpush start -e #{fetch(:rails_env)}"
          end
        end
      end
    end
  end

  desc 'Install rpush settings to DB'
  task :install => :environment do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'rpush:install_ios'
          execute :rake, 'rpush:install_android'
        end
      end
    end
  end

  desc 'UnInstall rpush settings to DB'
  task :uninstall => :environment do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'rpush:uninstall_ios'
          execute :rake, 'rpush:uninstall_android'
        end
      end
    end
  end
end

# after 'deploy:finished', 'rpush:install'
# after 'deploy:finished', 'rpush:restart_rpush'