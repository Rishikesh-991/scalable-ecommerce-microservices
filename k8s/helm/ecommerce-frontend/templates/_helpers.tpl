{{- define "ecommerce-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ecommerce-frontend.fullname" -}}
{{- printf "%s-%s" (include "ecommerce-frontend.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
