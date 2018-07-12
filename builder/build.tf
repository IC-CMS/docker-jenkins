# Build project

# in build.tf

provider "jenkins" {
    version = "0.1.0"
    server_url 				= "http://localhost:8080/jenkins"
    username 				= "${data.consul_keys.jenkins_build.var.jenkins_build_username}"
    password                            = "${data.vault_generic_secret.testuser_password.data["value"]}"
}

resource "jenkins_job" "jenkins-docker" {
   name = "jenkins-docker"
   display_name = "jenkins-docker Project"
   description = "jenkins-docker Test Build"
   disabled = false
   parameters = {
	KeepDependencies 		= true,
	GitLabConnection		= "${data.consul_keys.jenkins_build.var.git_url}",
	CredentialsId			= "testuser_id_rsa",
	TriggerOnPush			= true,
	TriggerOnMergeRequest		= true,
	TriggerOpenMergeRequestOnPush	= "never"
	TriggerOnNoteRequest		= true,
	NoteRegex			= "Jenkins please retry a build",
	CISSkip				= true,
	SkipWorkInProgressMergeRequest	= true,
        BranchFilterType		= "All",
	SecretToken			= "${data.vault_generic_secret.project_token.data["value"]}",
	UserRemoteConfig		= "${data.consul_keys.jenkins_build.var.git_url}",
	BranchSpec			= "${data.consul_keys.jenkins_build.var.branch_spec}",
	GenerateSubmoduleConfiguration	= false,
   }

   template = "file://./job_template.xml"
	
}
