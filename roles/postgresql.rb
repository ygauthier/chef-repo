name 'postgresql'
run_list('role[base]',
         'recipe[libpq-dev]',
         'recipe[postgresql::server]')
