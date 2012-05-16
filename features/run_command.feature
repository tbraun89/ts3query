Feature: Run a query command
	In order to run a command
	As an application
	I want to use a method after connection to the server
	
	Scenario: Run 'version' command
		Given I am connected to the default server with the password 0L8awVFD
		When I run the command version
		Then I should get a hash with version=3.0.5 build=1335156372 platform=Linux
		
	Scenario: Run 'serverlist' command with options
		Given I am connected to the default server with the password 0L8awVFD
		When I run the command serverlist with the options -uid -short
		Then I should get a hash with virtualserver_id=1 virtualserver_port=9987 virtualserver_status=online
		
	Scenario: Run 'use' command with parameters
		Given I am connected to the default server with the password 0L8awVFD
		When I run the command use with the parameters sid=1
		Then I should get a hash

	Scenario: Run 'use' command with options and parameters
		Given I am connected to the default server with the password 0L8awVFD
		When I run the command use with the options -virtual and the parameters sid=1
		Then I should get a hash
