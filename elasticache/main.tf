resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster1"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes     = 2
  parameter_group_name = "default.redis3.2"
  port                 = 6379

  tags = {
    Name        = "cluster1"
    Environment = "dev"
  }
  
}

resource "aws_elasticache_parameter_group" "cluster1_pg" {
  name        = "cluster1-pg"
  family      = "redis3.2"
  description = "Custom parameter group for Redis 3.2"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }
    parameter {
    name  = "activerehashing"
    value = "yes"
  }
}