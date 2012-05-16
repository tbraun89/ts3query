Given /^I am connected to the default server with the password (.+)$/ do |password|
  @query = TS3Query.connect :password => password
end

When /^I run the command version$/ do
  @result = @query.version()
end

When /^I run the command serverlist with the options (.+)$/ do |options|
  options = options.split(" ")
  @result = @query.serverlist do |opt|
    options.each do |current|
      current[0] = ""
      opt.send(current)
    end
  end
end

Then /^I should get a hash with (.+)$/ do |data|
  hash = {}
  data.split(" ").each do |entity|
    hash[entity.split("=")[0]] = entity.split("=")[1]
  end

  @result.should eq(hash)
end
