provider "aws" {
  region = "ap-northeast-2"
  profile = "bespin-aws4"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

terraform {
  backend "s3" {
    encrypt        = true
    key            = "db/terraform.tfstate"

    region         = "ap-northeast-2" 
    profile = "bespin-aws4"
    bucket         = "aws4-terraform-state"
    dynamodb_table = "a4-terraform-locks"
  }

  required_version = ">= 0.12.0"
}


module "db" {
  # source = "git::git@github.com:dudgns3443/AWS4FinalProject.git//terraform_template/db?ref=db-v0.01"
   source = "../../terraform_template/08_db"
      remote_bucket_name = var.remote_bucket_name
      region = var.region
      key = var.key
      name = var.name
      az = var.az
      route_cidr_global = var.route_cidr_global
      instance_type = var.instance_type
      bastion_pip = var.bastion_pip
      
    

      db_allocated_storage = 20
      db_max_allocated_storage = 100
      db_storage_type = "gp2"
      db_engine = "mysql"
      db_engine_ver = "8.0"
      db_instance_type = "db.t3.micro"
      db_name = "a4db"
      db_identifier = "a4db"

      #dbname, db passwd
      
      db_user = data.aws_ssm_parameter.a4db_username.value    # SSM or Secret Manger
      db_passwd = data.aws_ssm_parameter.a4db_passwd.value    # SSM or Secret Manger



      # Multi Available Zone
      

      # Maintenace, Backup
      maintenance_time = "Fri:22:00-Fri:23:00"

}