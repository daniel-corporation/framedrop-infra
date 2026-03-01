module "ecs_cluster" {
  source = "./cluster-ecs"

  cluster_name              = "framedrop-ecs-cluster"
  capacity_providers        = ["FARGATE", "FARGATE_SPOT"]
  enable_container_insights = true

  tags = {
    Environment = "dev"
    Project     = "framedrop"
  }
}

module "alb" {
  source = "./alb"

  tags = {
    Environment = "dev"
    Project     = "BaitersBurger"
  }
}

module ecr {
  source = "./ecr"

  tags = {
    Environment = "prod"
    Project     = "framedrop"
  }
}

module parameter_store {
  source = "./parameter-store"

  bucket_name = "framedrop-upload"
  sqs_video_processing_queue_url = "https://sqs.us-east-1.amazonaws.com/356821122440/framedrop-processing-queue"
  upload_api_base_url = "http://framedrop-alb-1620686225.us-east-1.elb.amazonaws.com"
}

module "s3" {
  source = "./s3"

}