namespace :croner do
  desc 'Update Cron'
  task update: :environment do
    result = Croner.run

    if result[:status]
      puts 'cron update success!'
    else
      puts result[:message]
    end
  end
end
