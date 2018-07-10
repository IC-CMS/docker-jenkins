#!groovy

import jenkins.*
import hudson.*

Thread.start {

  System.setProperty('jenkins.install.runSetupWizard', "false")
  println "--> Startup Wizard disabled"

}
