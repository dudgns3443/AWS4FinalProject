resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = var.port_redis
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet.name
  security_group_ids   = [data.terraform_remote_state.sg.outputs.redis_sg_id]
}
resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "tf-cache-subnet"
  subnet_ids = [data.terraform_remote_state.network.outputs.a4_sub_pri_db[0].id,data.terraform_remote_state.network.outputs.a4_sub_pri_db[1].id]
}