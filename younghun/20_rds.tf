resource "aws_db_instance" "yh_db"{
    allocated_storage= 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t2.micro"
    name = "wordpress"
    identifier = "database-1"
    username = "admin"
    password = "c6553443"
    parameter_group_name = "default.mysql8.0"
    availability_zone = "ap-northeast-2a"
    db_subnet_group_name = aws_db_subnet_group.db_subnet.name
    skip_final_snapshot = true
}
resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet2"
  subnet_ids = [aws_subnet.yh_pridb[0].id,aws_subnet.yh_pridb[1].id]
}