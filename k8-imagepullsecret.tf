locals {
	dockerconfigjson = {
		"auths" : {
			"${module.create_key_vault.docker_server}" = {
				email    = module.create_key_vault.docker_email
				username = module.create_key_vault.docker_username
				password = module.create_key_vault.docker_password
			}
		}
	}
}
resource "kubernetes_secret" "regcred" {
	metadata {
		name      = "regcred"
	}
	data = {
		".dockerconfigjson" = jsonencode(local.dockerconfigjson)
	}
	type = "kubernetes.io/dockerconfigjson"
}