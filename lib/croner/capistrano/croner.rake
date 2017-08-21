require 'capistrano/version'

if defined?(Capistrano::VERSION) && Gem::Version.new(Capistrano::VERSION).release >= Gem::Version.new('3.0.0')
  namespace :croner do
    desc "Update application's crontab entries using Croner"
    task :update_crontab do
      on roles(:db) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle, :exec, :rake, :"croner:update"
          end
        end
      end
    end

    after "deploy:updated",  "croner:update_crontab"
    after "deploy:reverted", "croner:update_crontab"
  end

  namespace :load do
    task :defaults do
      set :croner_roles, ->{ :db }
    end
  end
else
  ArgumentError.new('Required Capistrano Version >= 3.0')
end
