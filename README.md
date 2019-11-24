# Github Actions for Deploying Ember to S3 bucket

This action builds your ember code and push the build to S3 Bucket. 
This helps to automate your frontend deployment process.

## Prerequisites
1. Works only for ember app.
2. Ember repository should include following ember addons. 
    - ember-cli-deploy
    - ember-cli-deploy-build
    - ember-cli-deploy-display-revisions
    - ember-cli-deploy-gzip
    - ember-cli-deploy-revision-data
    - ember-cli-deploy-s3
    - ember-cli-deploy-s3-index
    
## Usage
 This action helps to push the ember build to S3 buckets on any events listed [here](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)

 Place in a .yml file such as this one in your .github/workflows folder. Refer to the documentation on workflow YAML syntax [here](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions).
```yaml
  jobs:
  build:

    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: manishankar2/EmberS3Deploy@1.0.0
      env:
        AWS_ACCESS_KEY_ID: ${{secrets.ACCESS_KEY_ID}}
        AWS_SECRET_ACCESS_KEY: ${{secrets.ACCESS_SECRET}}
        AWS_S3_BUCKET: frontendapp
        BUILD_ENV: staging
        SSH_PRIVATE_KEY: ${{secrets.SSH_PRIVATE_KEY}}
        BOWER: true
        REQUIRE_SSH: true
```
 Configure Encrypted secrets in your GITHUB repository for variables including your S3 ACCESS_KEY and SECRET. To know more about secrets refer this [link](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets#about-encrypted-secrets)
 
 If your ember app requires bower set the environment variable **BOWER** to true.
 
 Similarly if the app required some sort of addons which requires ssh_access set the variable **REQUIRE_SSH** to true. Also configure your SSH private key in the secrets and mention the key in the **SSH_PRIVATE_KEY** environmental variable.
 
 S3 Bucket will be created in the name of your brancg by default which can be overriden by using the **PREFIX** enviroment variable.
