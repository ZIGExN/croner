require 'croner/railtie'

module Croner
  require "open3"
  def self.run
    # ホスト名毎のcron設定ファイルがある場合に実行する
    return {status: false, message: ''} unless File.exist?(Rails.root.join('config', 'croner', 'hosts', `hostname`.delete("\n")))

    # 設定内容を取得
    insert_rows = File.read(Rails.root.join('config', 'croner', 'hosts', `hostname`.delete("\n"))).split("\n")

    # 現在のcron設定を取得
    cron_rows = `crontab -l`.split("\n")

    application_name = Rails.application.class.parent_name
    cron_start_row   = "# ==================== START #{application_name} CronJobs by Croner ===================="
    cron_end_row     = "# ====================  END  #{application_name} CronJobs by Croner ===================="

    start_index = cron_rows.index(cron_start_row)
    end_index   = cron_rows.index(cron_end_row)

    # 開始行か終了行のどちらかのみ存在する場合はエラー
    return ArgumentError.new('現在のcron設定にCronerによる不正な行が存在しています') unless ((start_index.present? && end_index.present?) || (start_index.blank? && end_index.blank?))

    if start_index.present? && end_index.present?
      # 既存の内容を削除
      cron_rows.slice!((start_index + 1)..(end_index - 1))
    else
      start_index = cron_rows.count
      cron_rows << cron_start_row
      cron_rows << cron_end_row
    end

    # cron設定を挿入
    cron_rows.insert(start_index + 1, *insert_rows)

    # ファイルに一時保存
    File.open("cron_tmp", "w") do |f| 
      cron_rows.each{|row| f.puts(row)}
    end

    # ファイルの内容をcronに出力
    stdout, stderror, status = Open3.capture3("crontab cron_tmp")

    # ファイルを削除
    File.delete("cron_tmp")

    if status.success?
      return {status: true}
    else
      return {status: false, message: stderror}
    end
  end
end
