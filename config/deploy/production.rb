#FIXME replace 1.2.3.4 with your IP address
server '54.175.244.248', user: 'deploy', roles: %w{web app db}
set :rails_env, 'production'
