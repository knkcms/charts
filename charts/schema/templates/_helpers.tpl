{{/*
Expand the name of the chart.
*/}}
{{- define "schema.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "schema.fullname" -}}
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
{{- define "schema.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "schema.labels" -}}
helm.sh/chart: {{ include "schema.chart" . }}
{{ include "schema.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "schema.selectorLabels" -}}
app.kubernetes.io/name: {{ include "schema.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "schema.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "schema.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define the url for postgres. TODO handling with "-" character
*/}}
{{- define "postgres.url" -}}
{{- printf "%s.postgres.database.azure.com" .Values.azure.postgres.database.name }}
{{- end }}

{{/*
Define the address for the http based endpoint
*/}}
{{- define "api.address" -}}
{{- printf "%s:%d" .Values.configs.server.api.host .Values.configs.server.api.port }}
{{- end }}

{{/*
Define the address for the grpc based endpoint
*/}}
{{- define "grpc.address" -}}
{{- printf "%s:%d" .Values.configs.server.grpc.host .Values.configs.server.grpc.port }}
{{- end }}
