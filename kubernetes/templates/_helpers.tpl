{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cray-sysmgmt-health.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cray-sysmgmt-health.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cray-sysmgmt-health.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "cray-sysmgmt-health.labels" -}}
app.kubernetes.io/name: {{ include "cray-sysmgmt-health.name" . }}
helm.sh/chart: {{ include "cray-sysmgmt-health.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "cray-sysmgmt-health.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "cray-sysmgmt-health.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "cray-sysmgmt-health.prometheus-operator.fullname" -}}
{{- if (index .Values "prometheus-operator" "fullnameOverride") -}}
{{- (index .Values "prometheus-operator" "fullnameOverride") | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "prometheus-operator" (index .Values "prometheus-operator" "nameOverride") -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 26 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "cray-sysmgmt-health.prometheus-operator.grafana.fullname" -}}
{{- if (index .Values "prometheus-operator" "grafana" "fullnameOverride") -}}
{{- (index .Values "prometheus-operator" "grafana" "fullnameOverride") | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "grafana" (index .Values "prometheus-operator" "grafana" "nameOverride") -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
