# Elven Observability Setup 🚀

Este guia fornece todas as informações necessárias para você conectar-se e começar a utilizar os serviços do Elven Observability.

## Conexão ao Grafana

Utilize as informações abaixo para conectar-se ao Grafana:

- **URL:** https://grafana.elvenobservability.com
- **Username:** `your-username`
- **Password:** `your-password`

## Uso do Token para Mimir, Loki e Tempo

Use o token abaixo para enviar dados aos serviços Mimir, Loki e Tempo:

- **Authorization: Bearer** `<API_TOKEN>`

## Mimir Endpoint

- **URL:** https://mimir.elvenobservability.com/api/v1/push
- **Método:** `POST`
- **Headers Necessários:**
    - `X-Scope-OrgID`: `<TENANT_ID>`
    - `Authorization: Bearer` `<API_TOKEN>`

### Exemplo de Configuração

Configure o Prometheus, OpenTelemetry Collector ou outro cliente para enviar logs para o Mimir, configurando o endpoint como acima.

## Loki Endpoint

- **URL:** https://loki.elvenobservability.com/loki/api/v1/push
- **Método:** `POST`
- **Headers Necessários:**
    - `X-Scope-OrgID`: `<TENANT_ID>`
    - `Authorization: Bearer` `<API_TOKEN>`

### Exemplo de Configuração

Configure o Promtail ou outro cliente para enviar logs para o Loki, configurando o endpoint como acima.

## Tempo HTTP Endpoint

- **URL:** https://tempo.elvenobservability.com/http
- **Método:** `POST`
- **Headers Necessários:**
    - `X-Scope-OrgID`: `<TENANT_ID>`
    - `Content-Type`: `application/json`
    - `Authorization: Bearer` `<API_TOKEN>`

### Exemplo de Configuração

Configure o OpenTelemetry Collector para enviar traces ao Tempo, usando o endpoint acima.

## Tempo gRPC Endpoint

- **URL:** https://tempo.elvenobservability.com/grpc
- **Método:** `gRPC`
- **Headers Necessários:**
    - `X-Scope-OrgID`: `<TENANT_ID>`
    - `Authorization: Bearer` `<API_TOKEN>`

### Exemplo de Configuração

Use o OpenTelemetry Collector ou outro cliente gRPC para enviar dados ao Tempo.

---

## Considerações Finais

- **Segurança:** Mantenha suas credenciais e tokens seguros. Não compartilhe com terceiros não autorizados.
- **Suporte:** Para qualquer dúvida ou problema, entre em contato com nossa equipe de suporte em support@elvenobservability.com.