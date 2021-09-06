resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = var.app_name
  engine                  = "aurora-postgresql"
  availability_zones      = var.subnets[*].availability_zone
  database_name           = var.db_name
  master_username         = var.db_user
  master_password         = var.db_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.aurora.id]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  //engine_version          = "9.6.8"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = var.node_count
  identifier           = "${var.app_name}-${count.index}"
  cluster_identifier   = aws_rds_cluster.postgresql.id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.postgresql.engine
  engine_version       = aws_rds_cluster.postgresql.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name

}

resource "aws_db_subnet_group" "default" {
  name       = var.app_name
  subnet_ids = var.subnets[*].id
}

resource "aws_security_group" "aurora" {
  name        = "${var.app_name}-db"
  description = "Access to prostgres"
  vpc_id      = var.vpc.id

  # MySQL access from anywhere in the VPC
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc.cidr_block]
    description = "Access form VPC"
  }

}
