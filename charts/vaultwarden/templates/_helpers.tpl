{{/*
Expand the name of the chart.
*/}}
{{- define "vaultwarden.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vaultwarden.fullname" -}}
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
{{- define "vaultwarden.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create database port.
*/}}
{{- define "db.port" -}}
{{- default 5432 }}
{{- end }}

{{/*
Create database fqdn.
*/}}
{{- define "db.fqdn" -}}
{{- printf "%s.postgres.database.azure.com" .Chart.Name }}
{{- end }}

{{/*
Create database name.
*/}}
{{- define "db.server" -}}
{{- default .Chart.Name }}
{{- end }}

{{/*
Create database name.
*/}}
{{- define "db.name" -}}
{{- default .Chart.Name }}
{{- end }}

{{/*
Create database user.
*/}}
{{- define "db.user" -}}
{{- default "admin" }}
{{- end }}

{{/*
Create database password.
*/}}
{{- define "db.password" -}}
# retrieve the secret data using lookup function and when not exists, return an empty dictionary / map as result
{{- $secret := (lookup "v1" "Secret" .Release.Namespace "admin-token") | default dict }}
# set $jwtSecret to existing secret data or generate a random one when not exists
{{- $jwtSecret := (get $secret "admin-token") | default (randAlphaNum 32 | b64enc) }}
{{- default $jwtSecret | b64enc | quote }}
{{- end }}

{{/*
Create database url.
"postgresql://${var.postgres_user}%40${data.azurerm_postgresql_server.pg.name}:${var.postgres_password}@${data.azurerm_postgresql_server.pg.fqdn}:${var.postgres_port}/${azurerm_postgresql_database.vaultwarden.name}"
*/}}
{{- define "vaultwarden.dbUrl" -}}
{{- printf "postgresql://%s%40:%s@%s:%s/%s" (include "db.user" .) (include "db.server" .) (include "db.password" .) (include "db.fqdn" .) (include "db.port" .) (include "db.name" .) }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vaultwarden.labels" -}}
helm.sh/chart: {{ include "vaultwarden.chart" . }}
{{ include "vaultwarden.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vaultwarden.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vaultwarden.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vaultwarden.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vaultwarden.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
