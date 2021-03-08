module "Blitline2-ecs-webservice" {
    source = "../ecs"

    app             = "ws"
    task_def        = "ecstask-ws.json"
    image_id        = data.aws_ssm_parameter.ecsami.value
    instance_size   = var.instance_size
    ec2_key         = var.ec2_key
    Blitline2_env   = var.Blitline2_env
    region          = var.region
    priv_subnets    = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    account_id      = data.aws_caller_identity.current.account_id
    kms_key_id      = aws_kms_key.Blitline2_ebs_kms.arn
    vpc_cidr        = var.vpc_cidr
    vpc_id          = aws_vpc.main.id
    target_group    = aws_lb_target_group.Blitline2wstg.arn
    container_port  = "80"
    
}

module "Blitline2-ecs-surly" {
    source = "../ecs"

    app             = "surly"
    task_def        = "ecstask-surly.json"
    image_id        = data.aws_ssm_parameter.ecsami.value
    instance_size   = var.instance_size
    ec2_key         = var.ec2_key
    Blitline2_env         = var.Blitline2_env
    region          = var.region
    priv_subnets    = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    account_id      = data.aws_caller_identity.current.account_id
    kms_key_id      = aws_kms_key.Blitline2_ebs_kms.arn
    vpc_cidr        = var.vpc_cidr
    vpc_id          = aws_vpc.main.id
    target_group    = aws_lb_target_group.Blitline2surlytg.arn
    container_port  = "8080"
}

module "Blitline2-ecs-blitline" {
    source = "../ecs"

    app             = "blitline"
    task_def        = "ecstask-blitline.json"
    image_id        = data.aws_ssm_parameter.ecsami.value
    instance_size   = var.instance_size
    ec2_key         = var.ec2_key
    Blitline2_env         = var.Blitline2_env
    region          = var.region
    priv_subnets    = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    account_id      = data.aws_caller_identity.current.account_id
    kms_key_id      = aws_kms_key.Blitline2_ebs_kms.arn
    vpc_cidr        = var.vpc_cidr
    vpc_id          = aws_vpc.main.id
    target_group    = aws_lb_target_group.Blitline2blitlinetg.arn
    container_port  = "8080"
}