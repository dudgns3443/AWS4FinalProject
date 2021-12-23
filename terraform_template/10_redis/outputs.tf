output "redis_dns_name" {
  value       = aws_elasticache_cluster.redis.cluster_address
}
