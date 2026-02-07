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
    Environment = "dev"
    Project     = "framedrop"
  }
}