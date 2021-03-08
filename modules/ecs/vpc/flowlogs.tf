resource "aws_flow_log" "Blitline2_flowlogs" {
    
    iam_role_arn    = aws_iam_role.Blitline2_flowlogs.arn
    log_destination = aws_cloudwatch_log_group.Blitline2_flowlogs.arn
    traffic_type    = "ALL"
    vpc_id          = aws_vpc.main.id

}

resource "aws_cloudwatch_log_group" "Blitline2_flowlogs" {
  name = "Blitline2-${var.Blitline2_env}-flow-logs"
}

resource "aws_iam_role" "Blitline2_flowlogs" {
    name = "Blitline2-${var.Blitline2_env}-Blitline2-flow-iamrole"
    assume_role_policy = data.aws_iam_policy_document.Blitline2_flow_assumerolepolicy.json
}


data "aws_iam_policy_document" "Blitline2_flow_assumerolepolicy" {
    statement {
        effect          = "Allow"
        actions         = ["sts:AssumeRole"]
        principals  {
            type        = "Service"
            identifiers = ["vpc-flow-logs.amazonaws.com"]

        }
  }
}
  
data "aws_iam_policy_document" "Blitline2_flow_rolepolicy" {

  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"

    ]

    resources = [
        "*"
    ]
  }


}

resource "aws_iam_role_policy" "Blitline2_flow_iampolicy" {
    name = "Blitline2-${var.Blitline2_env}-Blitline2-flow-policy"
    role = aws_iam_role.Blitline2_flowlogs.id
    policy = data.aws_iam_policy_document.Blitline2_flow_rolepolicy.json
}