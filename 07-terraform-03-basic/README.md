### 7.3. Основы и принцип работы Терраформ - Наталия Проворкова
#### 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).
provider "aws" {
<br>&nbsp;  region = "eu-north-1"
<br> }

<br>terraform {
<br>&nbsp;  backend "s3" {
<br>&nbsp;&nbsp;    bucket = "netology-state-dev"
<br>&nbsp;&nbsp;    key    = "bucket-key-path"
<br>&nbsp;&nbsp;    region = "eu-north-1"
<br>&nbsp;  }
<br>}

<br>data "terraform_remote_state" "network" {
<br>&nbsp;  backend = "s3"
<br>&nbsp;  config = {
<br>&nbsp;&nbsp;    bucket = "netology-state-dev"
<br>&nbsp;&nbsp;    key    = format( "env:/%s/bucket-key-path", terraform.workspace)
<br>&nbsp;&nbsp;    region = "eu-north-1"
<br>&nbsp;  }
<br>}

![bucket](backend/bucket.png)

#### 2. Инициализируем проект и создаем воркспейсы.
1. workspace list
![workspace-list](workspace-list.png)
2. terraform plan for prod-workspace
![workspace-prod-plan-1](workspace-prod-plan-1.png)
   <br>![workspace-prod-plan-2](workspace-prod-plan-2.png)
   <br>![workspace-prod-plan-3](workspace-prod-plan-3.png)
   <br>![workspace-prod-plan-4](workspace-prod-plan-4.png)
   <br>![workspace-prod-plan-5](workspace-prod-plan-5.png)
   <br>![workspace-prod-plan-6](workspace-prod-plan-6.png)
   <br>![workspace-prod-plan-7](workspace-prod-plan-7.png)
   <br>![workspace-prod-plan-8](workspace-prod-plan-8.png)
   <br>![workspace-prod-plan-9](workspace-prod-plan-9.png)
   <br>![workspace-prod-plan-10](workspace-prod-plan-10.png)
   <br>![workspace-prod-plan-11](workspace-prod-plan-11.png)
   <br>![workspace-prod-plan-12](workspace-prod-plan-12.png)