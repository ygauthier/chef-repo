name 'mysql'
run_list('role[base]',
         'recipe[mysql::server]')
override_attributes 'mysql' => { 'server_root_password' => '' }
