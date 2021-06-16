################################################################################
# Code Commit   
################################################################################

output "repository_id" {
    description = "The ID of the repository"
    value = aws_codecommit_repository.repo.repository_id
}

output "clone_url_http" {
    description = " The URL to use for cloning the repository over HTTPS."
    value = aws_codecommit_repository.repo.clone_url_http
}

output "clone_url_ssh" {
    description = "The URL to use for cloning the repository over SSH."
    value = aws_codecommit_repository.repo.clone_url_ssh
}
