terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "4.1.0"
    }
  }
}

provider "heroku" {
  #Configuration options
  email   = var.heroku_email
  api_key = var.heroku_api_key
}


#https://registry.terraform.io/providers/heroku/heroku/latest/docs/resources/

resource "heroku_app" "app_production" {
  name   = "monapptestklevishprod"
  region = "eu"
}

#Dans le terminal : 
# terraform plan : plan de l'infrastructure 
# terraform apply : montre ce qui va être fait puis demande confirmation
#d'appliquer les changements 

resource "heroku_addon" "db_production" {
  app  = heroku_app.app_production.name
  plan = "heroku-postgresql:hobby-dev"
}

#terminal : terraform plan, terraform apply


#meme chose app de staging 
resource "heroku_app" "app_staging" {
    name = "monapptestklevishstage"
    region= "eu"
}

resource "heroku_addon" "db_staging" {
  app  = heroku_app.app_staging.name
  plan = "heroku-postgresql:hobby-dev"
}


resource "heroku_pipeline" "pipeline" {  #creation de la pipeline
  name = "pipeline-devops"
}

resource "heroku_pipeline_coupling" "coupling_staging" { #lier un staging
  app      = heroku_app.app_staging.name
  pipeline = heroku_pipeline.pipeline.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "coupling_production" { #lier une prod
  app      = heroku_app.app_production.name
  pipeline = heroku_pipeline.pipeline.id
  stage    = "production"
}


