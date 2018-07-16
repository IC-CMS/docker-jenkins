node {

  def app

  stage ('Clone repository') {

    echo 'Checking out Docker-Jenkins Project'

    checkout scm
}

  stage ('Build image') {
 
    echo 'Beginning Build of Docker-Jenkins Project'

    app = docker.build("some project")

    echo 'Successfully completed Docker-Jenkins Build'
  }

}
