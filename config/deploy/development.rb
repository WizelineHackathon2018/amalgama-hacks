role :app, %w{deploy@18.204.205.78}
role :web, %w{deploy@18.204.205.78}
role :db,  %w{deploy@18.204.205.78}

set :deploy_to, '/srv/rails/wizeline'

server '18.204.205.78', user: 'deploy', roles: %w{web app}

set :rails_env, 'development'
set :branch, 'master'
