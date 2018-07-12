
############################################
# Data sources
############################################

# Region data
data "consul_keys" "region" {
  datacenter	= "dc1"

  key {
    name = "user"
    path = "${var.org}/REGION/user/${data.consul_keys.jenkins.var.region}"
  }
  key {
    name = "tenant"
    path = "${var.org}/REGION/tenant/${data.consul_keys.jenkins.var.region}"
  }
  key {
    name = "auth_url"
    path = "${var.org}/REGION/auth_url/${data.consul_keys.jenkins.var.region}"
  }
}

# Jenkins data
data "consul_keys" "jenkins" {
  datacenter 	= "dc1"

  key {
        name 	= "region"
        path 	= "${var.org}/${var.env}/${var.project}/region"
  }
  key {
        name 	= "vault_file"
        path 	= "${var.org}/${var.env}/${var.project}/vault_file"
  }

}

data "consul_keys" "jenkins_build" {
  datacenter    = "dc1"

 key {
        name    = "jenkins_build_username"
        path    = "${var.org}/${var.env}/${var.build_project}/jenkins_build_username"
  }
  key {
        name    = "branch_spec"
        path    = "${var.org}/${var.env}/${var.build_project}/branch_spec"
  }
  key {
        name    = "git_url"
        path    = "${var.org}/${var.env}/${var.build_project}/git_url"
  }

}


# Git Deploy Private Key
data "vault_generic_secret" "git_deploy_private_key" {
  path 		= "secret/${var.env}/jenkins/git_deploy_private_key"
}

# Test User Password
data "vault_generic_secret" "testuser_password" {
  path 		= "secret/${var.env}/jenkins/testuser_password"
}

# Git Deploy Token
data "vault_generic_secret" "project_token" {
  path 		= "secret/${var.env}/jenkins/token"
}
