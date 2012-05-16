Given /^I have the server address (.+) and the query port (.+)$/ do |address, port|
  @address = address
  @port    = port
end

When /^I enter the username (.+) with the password (.+)$/ do |username, password|
  @username = username
  @password = password
end

Then /^I should get a connection with valid response$/ do
  expect {
    @query = TS3Query.connect :address  => @address,
                              :port     => @port,
                              :username => @username,
                              :password => @password
                             
    @query.should be_kind_of(TS3Connection)
    @query.disconnect
  }.should_not raise_error
end

Then /^I should get a connection refused error: (.+)$/ do |error_msg|
  expect {
    @query = TS3Query.connect :address  => @address,
                              :port     => @port,
                              :username => @username,
                              :password => @password
  }.should raise_error(ConnectionRefused) { |error| error.message.should == error_msg }
end
