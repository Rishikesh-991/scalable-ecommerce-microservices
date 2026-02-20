# Architecture Diagrams

These diagrams reflect the current implementation and near-term platform design.

## 1) High-level architecture diagram

```mermaid
flowchart LR
  U[User Browser] --> FE[store-ui\nReact app :3000]

  FE --> P[products-cna-microservice\nNode.js/Express :5000]
  FE --> C[cart-cna-microservice\nSpring Boot :8080]
  FE --> US[users-cna-microservice\nFastAPI :9090]
  FE --> S[search-cna-microservice\nNode.js :4000]

  P --> MDB[(MongoDB)]
  C --> R[(Redis)]
  US --> PG[(PostgreSQL)]
  S --> ES[(Elasticsearch)]

  MQ[(RabbitMQ)]
  P -. planned async events .-> MQ
  C -. planned async events .-> MQ
  US -. planned async events .-> MQ
  S -. planned async events .-> MQ
```

## 2) Service-to-service communication diagram

```mermaid
sequenceDiagram
  participant UI as store-ui
  participant Products as Products API
  participant Cart as Cart API
  participant Users as Users API
  participant Search as Search API

  UI->>Products: GET /products/sku/{id}
  UI->>Products: GET /deals
  UI->>Cart: POST /cart
  UI->>Cart: GET /cart/{email}

  Note over UI,Users: Users API exists for user lifecycle APIs
  Note over UI,Search: Search API exists for search integration
  Note over Products,Search: Current traffic is primarily UI -> service
```

## 3) Event flow diagram (RabbitMQ / async messaging)

```mermaid
flowchart LR
  subgraph Producers[Potential Producers]
    P[Products API]
    C[Cart API]
    U[Users API]
  end

  P -- product.updated (planned) --> EX[(RabbitMQ exchange)]
  C -- cart.updated (planned) --> EX
  U -- user.created (planned) --> EX

  EX --> Q1[analytics queue]
  EX --> Q2[notifications queue]
  EX --> Q3[search-index queue]

  Q1 --> A[Analytics consumer]
  Q2 --> N[Notification consumer]
  Q3 --> SI[Search indexer]
```

## 4) Request lifecycle flowchart

```mermaid
flowchart TD
  A[User loads UI] --> B[React route renders page]
  B --> C[UI calls service API]
  C --> D{Target endpoint}

  D -->|Product details| E[Products API]
  D -->|Cart action| F[Cart API]
  D -->|User profile| G[Users API]
  D -->|Search query| H[Search API]

  E --> I[(MongoDB)]
  F --> J[(Redis)]
  G --> K[(PostgreSQL)]
  H --> L[(Elasticsearch)]

  I --> M[Service response]
  J --> M
  K --> M
  L --> M

  M --> N[UI updates state]
  N --> O[Rendered response to user]
```
