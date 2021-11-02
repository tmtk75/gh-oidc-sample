# README
A sample for https://github.blog/changelog/2021-10-27-github-actions-secure-cloud-deployments-with-openid-connect/
Call `get-caller-identity` of AWS in GitHub Actions using OIDC provider.

# Getting Started
```
$ terraform init
...

$ terraform plan -target aws_profile=your-profile-name
...

$ terraform apply --auto-approve
```

# Thanks
https://dev.classmethod.jp/articles/github-actions-without-permanent-credential/
