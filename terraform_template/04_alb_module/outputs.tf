/*output "a4_dns_name" {
  value = 
}*/

#템플릿
# alb_target_group_arn
output "a4_http_albtg_arn" {
  value = aws_lb_target_group.a4_http_albtg.arn
}

# alb_account_arn (made by kth)
output "a4_alb_arn" {
  value = aws_lb.a4_alb.arn
}