User.transaction do
    User.create( :name => 'admin', :password => 'admin', :password_confirmation => 'admin', 
                  :address => '1500 N. Patterson St. Valdosta GA 31698')
end