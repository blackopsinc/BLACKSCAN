provider "aws" {
  region = "us-west-2" 
}

resource "aws_ecs_cluster" "blackscan" {
  name = "blackscan"
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs-task-role"
  assume_role_policy = jsonencode({
    Version = "2024-07-29"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

resource "aws_ecs_task_definition" "blackscan" {
  family                   = "blackscan"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu                      = "256"
  memory                   = "512"

  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "blackscan"
      image     = "blackopsinc/pentest:latest"
      cpu       = 256
      memory    = 512
      essential = true
      command = ["/bin/bash", "-c", "systemctl enable amazon-ssm-agent && tail -f /dev/null"]
    }
  ])
}

resource "aws_security_group" "ecs_security_group" {
  name        = "blackscan-security-group"
  description = "Security group for blackscan"
  vpc_id      =  var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-security-group"
  }
}

resource "aws_ecs_service" "blackscan" {
  name            = "blackscan-service"
  cluster         = aws_ecs_cluster.blackscan.id
  task_definition = aws_ecs_task_definition.blackscan.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets           = [element(var.subnets, 0),element(var.subnets, 1),element(var.subnets, 2),element(var.subnets, 3)]
    security_groups  = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }
}
