# ENVIRONMENT
 - Ruby  2.2.0
 - Rails 4.2.3
 - SQLite3: develop & test
 - MySQL: production
 - Slim
 - Rspec
 - FactoryGirl

# SetUp

## ENV: development

~~~
bundle install --path=vendor/bundle --jobs=4
bundle exec rake db:migrate
bundle && npm i
bundle exec foreman start -f Procfile.dev
~~~

# Deploy

## To Production

### make .env file
- mysql settings
- server address
- secret key base

### first deploy task *Just Once*

~~~
bundle exec cap production deploy:check
bundle exec cap production util:upload
bundle exec cap production database:create
bundle exec cap production database:seed
~~~

### deploy routine

~~~
bundle exec cap production deploy
~~~

