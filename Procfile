web: bundle exec thin start -p $PORT -R config.ru
worker: bundle exec sidekiq -r./config/environment.rb