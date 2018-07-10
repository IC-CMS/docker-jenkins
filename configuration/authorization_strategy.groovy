#!groovy

import jenkins.model.*

def instance = Jenkins.getInstance()

import hudson.security.*

def realm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(realm)
// In real world, get password from vault
realm.createAccount("testuser", "Put a valid password here")

def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
