# knkCMS Identity Chart
The chart is used to deploy a *knkCMS Identity* service into a *kubernetes* cluster.

## Values
The following describes the values for the chart.

|Value|Description|Required|Default|
|-----|-----|:-----:|:-----:|
|replicaCount|Number of replicas to create.|(✅)|-|
|image.repository|Name of the repository to find the image.|❌|knkcms.azurecr.io/cms-identity|
|image.pullPolicy|Policy to pull the image.|❌|IfNotPresent|
|image.tag|Tag to pull and deploy.|❌|-|
|imagePullSecrets|Reference to the *kubernetes* secret to access a private image registry|❌|docker-cfg|
|nameOverride|Overrides the default naming.|❌|-|
|fullnameOverride|Overrides the default full naming.|❌|-|
|serviceAccount.create|Specifies whether a service account should be created.|❌|true|
|serviceAccount.annotations|Annotations to add to the service account.|❌|-|
|serviceAccount.name|The name of the service account to use.If not set and create is true, a name is generated using the fullname template.|(✅)|-|
|podAnnotations|Annotations to add to the created pods.|❌|-|
|podSecurityContext|Security context of the created pods.|❌|-|
|securityContext.capabilities|Defines the capabilities of the security context.|❌|-|
|securityContext.readOnlyRootFilesystem|Defines the readOnlyRootFilesystem of the security context.|❌|-|
|securityContext.runAsNonRoot|Defines the runAsNonRoot of the security context.|❌|-|
|securityContext.runAsUser|Defines the runAsUser of the security context.|❌|-|
|service.type|Defines the type of the service.|❌|ClusterIP|
|service.port|Defines the port of the service.|❌|8080|
|ingress.enabled|Enables creating an ingress.|❌|true|
|ingress.className|className for the ingress.|❌|-|
|ingress.annotations|Annotations to add to the created ingress.|❌|kubernetes.io/ingress.class: nginx <br/>kubernetes.io/tls-acme: "true" <br/>cert-manager.io/cluster-issuer: letsencrypt|
|ingress.hosts|List block of all hosts. At least one required.|✅|-|
|ingress.hosts.host|URI of the host.|✅|-|
|ingress.hosts.paths.path|Path of the URI.|❌|/|
|ingress.hosts.paths.pathType|PathType of the URI.|❌|ImplementationSpecific|
|ingress.tls|List block of all tls certificates. At least one required when using https.|✅|-|
|ingress.tls.secretName|Name of the secret to store the tls information.|❌|idp-tls|
|ingress.tls.hosts|List of all applying hosts.|✅|-|
|resources|Block to define the resources in *kubernetes*.|❌|-|
|resources.limits.cpu|Define limit for cpu usage.|❌|-|
|resources.limits.memory|Define limit for memory usage.|❌|-|
|resources.requests.cpu|Define requested cpu usage.|❌|-|
|resources.requests.memory|Define requested memory usage.|❌|-|
|autoscaling.enabled|Enables creating a HorizontalPodAutoscaler.|❌|false|
|autoscaling.minReplicas|Define minimum number of replicas for the pod autoscaller.|❌|1|
|autoscaling.maxReplicas|Define maximum number of replicas for the pod autoscaller.|❌|100|
|autoscaling.targetCPUUtilizationPercentage|Define target cpu usage of a replica for the pod autoscaller.|❌|80|
|autoscaling.targetMemoryUtilizationPercentage|Define target memory usage of a replica for the pod autoscaller.|❌|-|
|nodeSelector|List.|❌|-|
|tolerations|List block.|❌|-|
|affinity|List|❌|-|
|configs|Provide the configuration for the `identity` service. These values are needed to create the configmap. For configuration details take a look into [configuration](https://knk-cms.atlassian.net/wiki/spaces/identity/pages/1187381266/Configuration) of the `identity`.|✅|-|

## Kubernetes Resources
The Helm Chart will create the following resources into the *kubernetes* cluster.

|Resource|Dscription|
|--------|----------|
|Configmap|The Configmap stores all information to configure the `identity` service. The are coming from the `configs` part of the values.yaml|
|Deployment|The Deployment will create the pods and replica sets in kubernetes.|
|HorizontalPodAutoscaler|The horizontal pod autoscaler will only be created when the values.yaml include autoscaling.enabled equals true.|
|Ingress|The ingress will only be created when the values.yaml include ingress.enabled equals true.|
|Service|The Service is used to connect to the pods of the Deployment|
|ServiceAccount|The ServiceAccount is the account used to access the ressources within the *kubernetes* cluster.|