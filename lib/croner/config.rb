module Croner
  class Config
    # Variables detail is writen in lib/generators/templates/croner.rb.
    attr_accessor :enable_backup
    attr_accessor :backup_path
    attr_accessor :keep_backups
  end
end
