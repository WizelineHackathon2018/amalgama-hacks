role :app, %w{deploy@wizeline.amalgama.co}
role :web, %w{deploy@wizeline.amalgama.co}
role :db,  %w{deploy@wizeline.amalgama.co}

set :deploy_to, '/srv/rails/wizeline'

server 'wizeline.amalgama.co', user: 'deploy', roles: %w{web app}

set :rails_env, 'production'
set :branch, 'master'
