## Kindle Highlights

### Save your kindle highlights to DynamoDB

#### Instructions

* This project assumes you have own a domain in Route53.  Please follow the instructions [here](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/receiving-email-getting-started-verify.html) to verify your domain so it can be used to receive emails through SES.
* Copy `vars/kindle_highlights.tfvars.tmpl` to `vars/kindle_highlights.tfvars` and fill in the variables
* Make sure you have Terraform 0.12.16 installed
* Make sure the SES rule set you create is active
* Run `terraform init config/`
* Run `terraform apply --var-file=vars/kindle_highlights.tfvars config/`
* Go to your Kindle and export highlights to an email on your domain.  You should see the items populate in DynamoDB
