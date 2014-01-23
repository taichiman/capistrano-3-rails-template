lock '3.1.0'
# for capistrano3 setup have used tutorial http://www.talkingquickly.co.uk/2014/01/deploying-rails-apps-to-a-vps-with-capistrano-v3/
    # Gemfile.lock
    # capistrano (3.1.0)
    # capistrano-bundler (1.1.1)
    # capistrano-rails (1.1.1)
    # capistrano-rvm (0.1.1)

set :application, 'art-electronics'
set :user, ''

#setup repo details
set :scm, :git
set :repo_url, 'git@github.com:taichiman/open-cook.git'

#setup rvm
set :rvm_type, :system
set :rvm_ruby_version, 'ruby-2.1.0@art-electronics'

set :pty, true

#files and dirs we want symlinking to specific entries in shared
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

#what test should be run before deploy is allowed to continue
set :tests, ["spec"]

#which config files should be copy by deploy
set :config_files, %w(
  database.example.yml
  nginx.conf
  unicorn.rb
  unicorn_init.sh
)

#which config files should be make executable after copyng by deploy deploy:setup_config
set :executable_config_files, %w(unicorn_init.sh)

#files which need be symlinked
# set(:symlinks, [
#   {
#     source: "nginx.conf",
#     link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
#   },
#   {
#     source: "unicorn_init.sh",
#     link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
#   }
# ])

#join to main workflow
namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  # before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  # after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after :publishing, 'deploy:unicorn:restart'
end

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { rails_env: 'production' }

set :keep_releases, 5
set :ssh_options, {:forward_agent => true}

#gem capistrano-bundler
set :bundle_flags, '--deployment'

desc "run on server"
task :run_on do
  on roles :app do
    execute "id"
  end
end