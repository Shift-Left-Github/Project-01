output "Password" {
  description = "Outputs the admin passwords"
  value       = random_password.password.result
  sensitive = true
}
