#set(:deploy_to)         { "/home2/quack/site" }

set :deploy_to, -> {'/home2/quack/site' }
set :tmp_dir,   -> {'/tmp/quack'}

server '192.168.151.11', user: 'quack', roles: %w{web app db}

server '192.168.151.11',
        ssh_options: {
                user: 'quack',
                auth_methods: %w{password},
                password: 'CHANGEME'
        }
