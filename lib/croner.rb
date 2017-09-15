require 'croner/engine'
require 'croner/railtie'

module Croner
  require "open3"

  def self.run
    return {status: false, message: "couldn't found cron setting file"} unless File.exist?(Rails.root.join('config', 'croner', 'hosts', `hostname`.delete("\n")))

    # get cron contents
    insert_rows = File.read(Rails.root.join('config', 'croner', 'hosts', `hostname`.delete("\n"))).split("\n")

    # backup current cron contents
    if Croner.config.enable_backup
      if Croner.config.backup_path.blank?
        backup_path = '.'
      else
        backup_path = "./#{Croner.config.backup_path}"
      end
      `crontab -l > #{backup_path}/cron_#{Time.current.strftime('%Y%m%d%H%M%S')}.bak`

      # delete over backup files
      backup_files = Dir.glob("#{backup_path}/cron_*.bak")
      if backup_files.count > Croner.config.keep_backups
        backup_dates = backup_files.map do |backup_file|
          backup_file.match(/cron_([0-9]{14}).bak$/)[1] rescue nil
        end
        delete_backup_files = backup_dates.compact.sort.first(backup_files.count - Croner.config.keep_backups).map{|backup_date| "#{backup_path}/cron_#{backup_date}.bak"}
        delete_backup_files.each do |delete_backup_file|
          File.delete(delete_backup_file)
        end
      end
    end

    # get current cron contents
    cron_rows = `crontab -l`.split("\n")

    application_name = Rails.application.class.parent_name
    cron_start_row   = "# ==================== START #{application_name} CronJobs by Croner ===================="
    cron_end_row     = "# ====================  END  #{application_name} CronJobs by Croner ===================="

    start_index = cron_rows.index(cron_start_row)
    end_index   = cron_rows.index(cron_end_row)

    return ArgumentError.new('current cron contents has unvalid settings by Croner!') unless ((start_index.present? && end_index.present?) || (start_index.blank? && end_index.blank?))

    if start_index.present? && end_index.present?
      cron_rows.slice!((start_index + 1)..(end_index - 1))
    else
      start_index = cron_rows.count
      cron_rows << cron_start_row
      cron_rows << cron_end_row
    end

    cron_rows.insert(start_index + 1, *insert_rows)

    File.open("cron_tmp", "w") do |f| 
      cron_rows.each{|row| f.puts(row)}
    end

    stdout, stderror, status = Open3.capture3("crontab cron_tmp")

    File.delete("cron_tmp")

    if status.success?
      return {status: true}
    else
      return {status: false, message: stderror}
    end
  end
end
