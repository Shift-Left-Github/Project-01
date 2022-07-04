/*
output "Password" {
  description = "Outputs the admin passwords"
  value       = random_password.password.result
  sensitive = true
}

May need to add this to the module vs the main file.
*/