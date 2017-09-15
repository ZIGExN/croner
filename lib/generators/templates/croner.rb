Croner.configure do |config|
  # enable Backup
  config.enable_backup = true

  # Backup path
  config.backup_path   = ""

  # num of keep backups
  config.keep_backups  = 5
end
