namespace :database do

  task :seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  task :create do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  task :reset do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:migrate:reset'
        end
      end
    end
  end

end