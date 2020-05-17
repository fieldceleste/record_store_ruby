require 'rspec'
require 'pg'
require 'album'
require 'song'
require 'pry'

# this line of code connects ruby to the psql database using the constant 'DB' and is now available anywhere in our program. 
DB = PG.connect({:dbname => 'record_store_test'}) 

# the next 6 lines  of code replace our before(:each) blocks we used last week, we're clearing out the test database instead of a class variable each time. 
RSpec.configure do |config|
  config.after(:each) do  
    DB.exec("DELETE FROM albums *;")
    DB.exec("DELETE FROM songs *;")
  end
end


