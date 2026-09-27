# Clean Architecture — Listagem de Orders

`ListOrdersUseCase` exposto simultaneamente via REST, gRPC e GraphQL, sobre a base Clean
Architecture do curso (Order → REST/gRPC/GraphQL/RabbitMQ já existente).

## Rodando

```
docker compose up --build
```

Um único comando: sobe o MySQL, aplica as migrações automaticamente (a aplicação aguarda o banco
ficar saudável antes de migrar e iniciar), sobe o RabbitMQ, e inicia a aplicação nas três portas
abaixo.

## Portas

| Serviço | Porta |
|---|---|
| Web (REST) | 8000 |
| gRPC | 50051 |
| GraphQL | 8080 |

## Testando

`api.http` na raiz tem as duas requisições prontas (criar uma order, depois listar). Ou via curl:

```
curl -X POST http://localhost:8000/order -d '{"id":"a","price":100.5,"tax":0.5}'
curl http://localhost:8000/order
```

GraphQL: abra `http://localhost:8080` (playground) e rode `{ listOrders { id Price Tax
FinalPrice } }`.

gRPC: `ListOrders` no serviço `pb.OrderService`, porta 50051 (reflection habilitada, testável com
`grpcurl -plaintext localhost:50051 pb.OrderService/ListOrders`).
