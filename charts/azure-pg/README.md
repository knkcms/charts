# Azure Flexible Server for `postgres`

**Attention**
This chart is not a standalone chart. It should only be used as `dependency` in other charts.
The chart requires that the main chart is creating a secret with following information provided.
It is important that the secret is named as `azurepg-secret` and includes a key `PASSWORD`.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: azurepg-secret
type: Opaque
stringData:
  {{- $pwd := (lookup "v1" "Secret" .Release.Namespace "jwt-pwd") | default dict }}
  {{- $pwdData := (get $pwd "data") | default dict }}
  {{- $pwdSecret := (get $pwdData "PASSWORD") | default (randAlphaNum 32 | b64enc) }}
  PASSWORD: {{ $pwdSecret | b64enc | quote }}
```
