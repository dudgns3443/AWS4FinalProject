# Healthcare-server-provisioning-by-terraform-AWS
모듈화 - 각 리소스간의 coupling을 줄이고 cohesion을 높이기 위함(협업을 수월하게해 생산성을 높이기위함)

각 모듈들은 taging을 이용해 versioning을 구현
(각 모듈별로 레포지토리를 따로 두는 것이 더 이상적)

terraform_template : 실제 모듈, 리소스들이 들어있는 곳 변경가능성이 높은 값들은 변수로 빼냄

ㄴ [0X_resourcename] : 각 모듈을 폴더단위로 분리

    ㄴ resoucename.tf : 실제 리소스들의 생성코드들이 작성되어있음
  
    ㄴ var.tf : 변경가능성이 높은 값들은 변수로 리팩토링, terraform 코드의 재사용성을 높이기 위해사용
  
    ㄴ global.tf : 각 모듈들이 공통으로 쓰는 고정 변수값을 저장
  
    ㄴ outputs.tf : 다른 모듈들이 참조할 변수들을 노출시키기 위함
  
    ㄴ remote_state_data.tf : 다른 모듈의 state파일을 가져와 output 변수를 이용해 참조하고 사용하기 위함
  
  
terraform_config : state를 저장할 remote 저장소, 실제 리소스를 실행할 profile, 변수들의 실제 값들으 정해서 실제 실행을 하는곳

ㄴ 0X_[resoucename] : 각 모듈을 폴더단위로 분리

    ㄴmain.tf : main provider 선택, 계정 선택, remote_state 저장소 선택, 실제 실행할 모듈 지정, 사용할 변수값입력
              등과 같은 실제 모듈을 실행하는 곳
              
    ㄴglobals.tf : 모든 모듈이 사용하는 공통변수를 정의 (provider, 계정 등)
  
    ㄴoutputs.tf : 실제 다른 모듈들이 참조할 수 있게 변수를 노출시켜주기 위한 곳 여기서 정의한 변수이름으로만 참조가능
                 (template의 outputs 변수이름은 다른 모듈에서 참조불가능)
                 

remote_state : terraform의 상태파일(terraform.state)을 각 사용자가 공유하기위해 s3에 저장
