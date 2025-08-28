output "rds_cluster_endpoint" {
  value = aws_rds_cluster.rds-cluster-1.endpoint
}

output "rds_cluster_reader_endpoint" {
  value = aws_rds_cluster.rds-cluster-1.reader_endpoint
}
