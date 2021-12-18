/*output "a4_dns_name" {
  value = module.alb.a4_dns_name
}*/

#컨피그 
# alb_target_group_arn
output "a4_http_albtg_arn" {
  value = module.alb.a4_http_albtg_arn
}

# alb_account_arn (made by kth)
output "a4_alb_arn" {
  value = module.alb.a4_alb_arn
}