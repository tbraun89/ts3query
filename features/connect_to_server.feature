Feature: Connect with a teamspeak server
	In order to connect to the server
	As an application
	I want to establish a connection and check the server version
	
	Scenario: Establish a connection
		Given I have the server address 127.0.0.1 and the query port 10011
		When I enter the username serveradmin with the password 0L8awVFD
		Then I should get a connection with valid response

	Scenario: Try to establish a connection with wrong server data
		Given I have the server address 127.0.0.1 and the query port 11100
		When I enter the username serveradmin with the password 0L8awVFD
		Then I should get a connection refused error: server not available
		
	Scenario: Try to establish a connection with wrong user data
		Given I have the server address 127.0.0.1 and the query port 10011
		When I enter the username serveradmin with the password 903jsdp
		Then I should get a connection refused error: wrong user data