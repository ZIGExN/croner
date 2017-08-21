module Croner
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/croner_tasks.rake"
    end
  end
end
