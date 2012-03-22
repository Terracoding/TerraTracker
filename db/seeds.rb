company = Company.create(:name => "TerraCoding", :registration_number => "1001")
user = User.create(:company => company, :owns_company => true, :email => "domness@gmail.com", :firstname => "Dominic", :lastname => "Wroblewski", :password => "password", :password_confirmation => "password")
