set :application, 'peatio_production'
set :stage, :production
set :rails_env, :production
set :deploy_to, '/home/deploy/peatio_production'
set :release_note_url, 'http://staging.peatio.com/release_note.txt'

server '13.250.151.1', user: 'deploy', roles: %w{web app db job}
