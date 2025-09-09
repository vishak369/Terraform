output "lambda_function_name" {
  value = aws_lambda_function.lambda_fn1.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda_fn1.arn
}
