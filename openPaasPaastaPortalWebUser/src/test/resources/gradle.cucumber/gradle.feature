Feature: User Potal

  Scenario: Application Behavior
    Given i login by "junit-test-user" and "1234"
    Then i will test "test-app" in org "app-test-org", space "app-test-space"
    When "restage" application with url "/app/restageApp"
    Then "audit.app.restage" event occurs
    When "stop" application with url "/app/stopApp"
    Then "audit.app.update" event occurs
    And It is the "STOPPED" status
    When "start" application with url "/app/startApp"
    Then "audit.app.update" event occurs
    And It is the "STARTED" status


  Scenario: Organization And Space Behavior
    Given i login by "junit-test-user" and "1234"
    When create organization "create-test-org"
    Then "create-test-org" organization successfully created
    When create space "create-test-space" in organization "create-test-org"
    Then "create-test-space" space in organization "create-test-org" successfully created
    When delete space "create-test-space" in organization "create-test-org"
    Then "create-test-space" space in organization "create-test-org" successfully delete
    When delete organization "create-test-org"
    Then "create-test-org" organization successfully delete

  Scenario: Service Behavior
    Given i login by "junit-test-user" and "1234"
    Then i will test in organization "app-test-org", space "app-test-space"
    When create service instance "cucumber-test-service-instance" with plan "Mysql-Plan1-10con" and service "Mysql-DB"
    Then service instance "cucumber-test-service-instance" successfully created with plan "Mysql-Plan1-10con" and service "Mysql-DB"
    When bind service instance "cucumber-test-service-instance" and application "test-app"
    Then service instance "cucumber-test-service-instance" and application "test-app" successfully bound
    When unbind service instance "cucumber-test-service-instance" and application "test-app"
    Then service instance "cucumber-test-service-instance" and application "test-app" successfully unbound
    When delete service instance "cucumber-test-service-instance"
    Then service instance "cucumber-test-service-instance" successfully deleted