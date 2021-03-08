#Building an ECS Cluster
resource "aws_ecs_cluster" "Blitline2_cluster" {
  name                          = "Blitline2-${var.app}-${var.Blitline2_env}"
  capacity_providers            =  [aws_ecs_capacity_provider.Blitline2-capacity.name]
  default_capacity_provider_strategy {
      capacity_provider = aws_ecs_capacity_provider.Blitline2-capacity.name


  }
  setting {
      name = "containerInsights"
      value = "enabled"
  }
}


#ECS Requires a capacity provider
resource "aws_ecs_capacity_provider" "Blitline2-capacity" {
  name      = "Blitline2-${var.app}-${var.Blitline2_env}-capacity-default"

  auto_scaling_group_provider {
    auto_scaling_group_arn          = aws_autoscaling_group.Blitline2-asg.arn

    managed_scaling{
      maximum_scaling_step_size   = 1000
      minimum_scaling_step_size   = 1
      status                      = "ENABLED"
      target_capacity             = 50
    }
  }
}


#Create the ECS TBlitline2, currently it is only supported to import based on json file
resource "aws_ecs_task_definition" "taskdef" {
  family                  = "Blitline2-ecs-${var.app}-${var.Blitline2_env}"
  container_definitions   = templatefile("${path.module}/${var.task_def}", {Blitline2env = var.Blitline2_env, region = var.region, accountid=var.account_id})
  execution_role_arn      = aws_iam_role.Blitline2ecsrole.arn
}

#Create the ECS service for WS
resource "aws_ecs_service" "Blitline2-service" {
  name                                = "Blitline2-${var.app}-${var.Blitline2_env}"
  cluster                             = aws_ecs_cluster.Blitline2_cluster.id
  task_definition                     = aws_ecs_task_definition.taskdef.arn
  desired_count                       = 2
  deployment_minimum_healthy_percent  = 50
  deployment_maximum_percent          = 200
  launch_type                         = "EC2"
  iam_role                            = aws_iam_role.Blitline2ecsrole.arn
  force_new_deployment                = true

  load_balancer {
    target_group_arn              = var.target_group #aws_lb_target_group.Blitline2wstg.arn
    container_name                = "Blitline2-${var.app}"
    container_port                = var.container_port  
  }


}



