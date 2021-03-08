resource "aws_ssm_parameter" "cloudwatch" {
  name  = "/${var.Blitline2_env}/ops.cloudwatch"
  type  = "String"
  tier  = "Advanced"
  value = templatefile("${path.module}/${var.cloudwatch_file}", {Blitline2env = var.Blitline2_env})
  overwrite = true

}