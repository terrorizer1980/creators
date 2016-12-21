# was 192.168.11.11
server 'creators.101.net', user: 'creators', roles: %w{web app db}

server 'creators.101.net',
        ssh_options: {
                user: 'creators',
                auth_methods: %w{password},
                password: 'CHANGEME'
        }


	