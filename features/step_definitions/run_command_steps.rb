Given /^I am connected to the default server with the password (.+)$/ do |password|
  @query = TS3Query.connect :password => password
end

When /^I run the command version$/ do
  @result = @query.version()
  @query.disconnect
end

When /^I run the command serverlist with the options (.+)$/ do |options|
  options = options.split(" ")
  @result = @query.serverlist do |opt|
    options.each do |current|
      current[0] = ""
      opt.send(current)
    end
  end
  @query.disconnect
end

When /^I run the command use with the parameters (.+)$/ do |parameters|
  parameters = parameters.split(" ")
  params = {}
  parameters.each do |current|
    params[current.split("=")[0]] = current.split("=")[1]
  end
  @result = @query.use params
  @query.disconnect
end

When /^I run the command use with the options (.+) and the parameters (.+)$/ do |options, parameters|
  parameters = parameters.split(" ")
  params = {}
  parameters.each do |current|
    params[current.split("=")[0]] = current.split("=")[1]
  end
  
  options = options.split(" ")
  @result = @query.use params do |opt|
    options.each do |current|
      current[0] = ""
      opt.send(current)
    end
  end
  @query.disconnect
end

Then /^I should get a hash with (.+)$/ do |data|
  list = []
  hash = {}
  
  data.split(" ").each do |entity|
    hash[entity.split("=")[0]] = entity.split("=")[1]
  end
  list << hash
  list << {"id" => "0", "msg" => "ok"}

  @result.should eq(list)
end

Then /^I should get a hash$/ do
  list = [{"id" => "0", "msg" => "ok"}]
  @result.should eq(list)
end