node {

  def app

  stage ('Clone repository') {

    echo 'Checking out Automation Test Project'

    checkout scm
}

  stage ('Build image') {
 
    echo 'Beginning Build of Automation Test'

    app = docker.build("some project")

    echo 'Successfully completed AutomationTest Build'
  }

}
