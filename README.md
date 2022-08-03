#  Repository for our Helm Charts and manifests.

References:

* https://opensource.com/article/20/5/helm-charts

## Create a new application with ArgoCD CLI
https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_login/
user admin
pw 0cmy4VhLSoK-zjAq
```
argocd login argocd.knkcms-eu-west.knkcms.io
argocd app get schema
```

## GitOps
https://medium.com/devopsturkiye/self-managed-argo-cd-app-of-everything-a226eb100cf0

```
eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa_github
```