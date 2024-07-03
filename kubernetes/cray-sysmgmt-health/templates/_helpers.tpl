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

{{- define "cray-sysmgmt-health.victoria-metrics-k8s-stack.fullname" -}}
{{- if (index .Values "victoria-metrics-k8s-stack" "fullnameOverride") -}}
{{- (index .Values "victoria-metrics-k8s-stack" "fullnameOverride") | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "victoria-metrics-k8s-stack" (index .Values "victoria-metrics-k8s-stack" "nameOverride") -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 20 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "cray-sysmgmt-health.prometheus-snmp-exporter.fullname" -}}
{{- if (index .Values "prometheus-snmp-exporter" "fullnameOverride") -}}
{{- (index .Values "prometheus-snmp-exporter" "fullnameOverride") | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "prometheus-snmp-exporter" (index .Values "prometheus-snmp-exporter" "nameOverride") -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 20 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- define "cray-sysmgmt-health.prometheus-snmp-exporter.labels" -}}
app.kubernetes.io/name: {{ include "cray-sysmgmt-health.prometheus-snmp-exporter.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "cray-sysmgmt-health.prometheus-snmp-exporter.selectorLabels" }}
app.kubernetes.io/name: {{ include "cray-sysmgmt-health.prometheus-snmp-exporter.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Prometheus custom resource instance name */}}
{{- define "victoria-metrics-k8s-stack.prometheus.crname" -}}
{{- if .Values.cleanPrometheusOperatorObjectNames }}
{{- include "victoria-metrics-k8s-stack.fullname" . }}
{{- else }}
{{- print (include "victoria-metrics-k8s-stack.fullname" .) "-prom" }}
{{- end }}
{{- end }}

{{- define "cray-sysmgmt-health.victoria-metrics-k8s-stack.grafana.fullname" -}}
{{- if (index .Values "victoria-metrics-k8s-stack" "grafana" "fullnameOverride") -}}
{{- (index .Values "victoria-metrics-k8s-stack" "grafana" "fullnameOverride") | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "grafana" (index .Values "victoria-metrics-k8s-stack" "grafana" "nameOverride") -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
