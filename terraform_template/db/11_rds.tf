resource "aws_db_instance" "a4_final_db" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_ver
  instance_class       = var.db_instance_type
  name                 = var.db_name
  identifier           = var.db_identifier
  username             = var.db_user   # SSM or Secrete Manager
  password             = var.db_passwd # SSM or Secrete Manager
  parameter_group_name = var.db_parameter_group_name
  availability_zone    = "${var.region}${var.az[0]}"
  # multi_az = true
  db_subnet_group_name   = aws_db_subnet_group.a4_dbsg.id
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.db_sg_id]
  skip_final_snapshot    = true
  tags = {
    "Name" = "a4-db"
  }
  deletion_protection = false # 자동 삭제 방지 default -> off


  # Automated Backup
  # maintenance와 겹치지 않을 것


  backup_window            = var.backup_time      # 자동 백업이 실행된 경우 생성되는 일별 시간범위: ex)매주 월요일 AM 09:00 ~ AM 10:30 로 설정
  backup_retention_period  = var.retention_period # 백업 보존 기간       
  delete_automated_backups = true                 # default는 true db인스턴스가 생성되고 백업파일을 삭제할 것 인지    

  /*
    restore_to_point_in_time {
        
        source_db_instance_identifier = var.db_identifier
        source_dbi_resource_id = "aws4teamrestoredb" # Mu
        use_latest_restorable_time = true
        }
  */


  # 자동으로 마지막으로 생성된 백업 파일로 복구할 것 인지
  # 유지 관리
  maintenance_window         = var.maintenance_time # 유지 보수할 시간 설정 : ex)매주 월요일 AM 09:00 ~ AM 10:30 로 설정
  auto_minor_version_upgrade = true
  # 클라우드 왓치 로그
  enabled_cloudwatch_logs_exports = ["error", "audit", "general"]
}


resource "aws_db_subnet_group" "a4_dbsg" {
    name = "a4-dbsg"
    subnet_ids = [
        data.terraform_remote_state.network.outputs.a4_sub_pri_db[0].id,
        data.terraform_remote_state.network.outputs.a4_sub_pri_db[1].id
    ]
    tags = {
        "Name" = "${var.name}-dbsg"
    }
}

# 스냅샷
resource "aws_db_snapshot" "a4_db_snapshot" {
  db_instance_identifier = aws_db_instance.a4_final_db.id
  db_snapshot_identifier = "aws4dbsnapshot"

}