namespace :rpush do

  task install_ios: :environment do |current_task|
    puts "start #{current_task.name}"

    app_name = ENV['RPUSH_APP_NAME']
    apns_env = ENV['APNS_ENV'] ? ENV['APNS_ENV'] : (Rails.env.production? ? 'production' : 'sandbox')

    if Rpush::Apns::App.exists?(name: app_name, environment: apns_env)
      puts "already exists: (Rpush::Apns::App (name:#{app_name} environment:#{apns_env}))"

      next # end the task (almost same as method's return)
    end

    certificate_path = Rails.root.join('certificates', 'apns', "#{apns_env}.pem")

    Rpush::Apns::App.create!(
      name: app_name,
      certificate: File.read(certificate_path),
      environment: apns_env,
      password: ENV['RPUSH_APNS_PASSWORD'],
      connections: 1
    )
    puts "saved: RAILS_ENV=#{Rails.env}, APNS_ENV=#{apns_env}, certificate_path=#{certificate_path}"

    puts "end #{current_task.name}"
  end

  task install_android: :environment do |current_task|
    puts "start #{current_task.name}"

    app_name = ENV['RPUSH_APP_NAME']

    if Rpush::Gcm::App.exists?(name: app_name)
      puts "already exists: (Rpush::Gcm::App (name: #{app_name}))"

      next # end the task (almost same as method's return)
    end

    Rpush::Gcm::App.create!(
      name: app_name,
      auth_key: ENV['RPUSH_GCM_AUTH_KEY'],
      connections: 1
    )
    puts "saved: RAILS_ENV=#{Rails.env}, GCM"

    puts "end #{current_task.name}"
  end

  task uninstall_ios: :environment do |current_task|
    puts "start #{current_task.name}"
    Rpush::Apns::App.delete_all
    puts "end #{current_task.name}"
  end

  task uninstall_android: :environment do |current_task|
    puts "start #{current_task.name}"
    Rpush::Gcm::App.delete_all
    puts "end #{current_task.name}"
  end
end