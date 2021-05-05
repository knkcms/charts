{{/*
Expand the name of the chart.
*/}}
{{- define "cms-core.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cms-core.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cms-core.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cms-core.labels" -}}
helm.sh/chart: {{ include "cms-core.chart" . }}
{{ include "cms-core.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cms-core.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cms-core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cms-core.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cms-core.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the name of the area service.
*/}}
{{- define "cms-core.areaService" -}}
{{- default "area-service" }}
{{- end }}

{{/*
Expand the name of the frontend service.
*/}}
{{- define "cms-core.frontendService" -}}
{{- default "frontend-service" }}
{{- end }}

{{/*
Selector area labels
*/}}
{{- define "cms-core.selectorAreaLabels" -}}
app.kubernetes.io/name: {{ include "cms-core.areaService" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector frontend labels
*/}}
{{- define "cms-core.selectorFrontendLabels" -}}
app.kubernetes.io/name: {{ include "cms-core.frontendService" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Docker Secrets
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.docker.registry_server (printf "%s:%s" .Values.docker.registry_username .Values.docker.registry_password | b64enc) | b64enc }}
{{- end }}
