
#This is to create the IAM Policies for the ECS tBlitline2s, these policies are specific to Blitline2 and may need adjustment for other applications (How do we generalize this?)
#ECS Role, allows ECS services to assume STS roles
data "aws_iam_policy_document" "Blitline2ecsrole"{
statement {
    effect          = "Allow"
    actions         = ["sts:AssumeRole"]
    principals  {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ecs.amazonaws.com","ecs-tasks.amazonaws.com"]

    }
  }
  
}
#STS Policy
data "aws_iam_policy_document" "Blitline2ecsrolepolicy" {

  statement {
    effect = "Allow"
    actions = [
                "ssmmessages:OpenDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:CreateControlChannel",
                "ssm:UpdateInstanceInformation",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateAssociationStatus",
                "ssm:PutInventory",
                "ssm:PutConfigurePackageResult",
                "ssm:PutComplianceItems",
                "ssm:ListInstanceAssociations",
                "ssm:ListAssociations",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "ssm:GetManifest",
                "ssm:GetDocument",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:DescribeParameters",
                "ssm:DescribeDocument",
                "ssm:DescribeAssociation",
                "elasticloadbalancing:*",
                "ecs:*",
                "ecr:*",
                "ec2messages:SendReply",
                "ec2messages:GetMessages",
                "ec2messages:GetEndpoint",
                "ec2messages:FailMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:AcknowledgeMessage",
                "application-autoscaling:*",
                "sts:*",
                "kms:Decrypt",
                "logs:GetLogEvents",
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:PutRetentionPolicy",
                "logs:CreateLogGroup",
                "rds:DescribeDBClusters"

    ]

    resources = [
        "*"
    ]
  }


}


#Create the IAM Role based on above policy
resource "aws_iam_role" "Blitline2ecsrole" {
  name                = "wb-cmd-Blitline2-ecs-${var.app}-${var.Blitline2_env}-${var.region}-Blitline2ECSRole"
  assume_role_policy  = data.aws_iam_policy_document.Blitline2ecsrole.json
}

#Create the IAM/ECS profile based on the policy
resource "aws_iam_instance_profile" "wb-cmd-Blitline2-ecs-Blitline2-Blitline2ECSInstanceProfile" {
  name      = "wb-cmd-Blitline2-ecs--${var.app}-${var.Blitline2_env}-${var.region}-Blitline2ECSInstanceProfile"
  role      = aws_iam_role.Blitline2ecsrole.name
}

#Assign the policy to the role
resource "aws_iam_role_policy" "Blitline2ecsrolepolicy" {
  name      = "Blitline2-ecs"
  role      = aws_iam_role.Blitline2ecsrole.id
  policy     = data.aws_iam_policy_document.Blitline2ecsrolepolicy.json
}

#Assign the policy to the role
resource "aws_iam_role_policy_attachment" "cloudwatchagentserverpolicy" {
  role                = aws_iam_role.Blitline2ecsrole.id
  policy_arn          = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}