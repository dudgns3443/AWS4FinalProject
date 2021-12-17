/*output "a4_dns_name" {
  value = 
}*/

#템플릿

output "a4_http_albtg_arn" {
  value = aws_lb_target_group.a4_http_albtg.arn
}