provider "aws"{
    region = "us-east-1"
}

resource "aws_elasticsearch_domain" "elasticsearch-dev" {
    domain_name = "elasticsearch-domain1"
    elasticsearch_version = "7.10"  

    cluster_config {
        instance_type = "t2.small.elasticsearch"
        instance_count = 1
    }
    tags = {
        Environment = "dev"
    }
  
}
  
output "elasticsearch_domain_endpoint" {
    value = aws_elasticsearch_domain.elasticsearch-dev.endpoint
}