.DEFAULT_GOAL := help

define HELP

Available commands:

  Cluster Lifecycle:
    run             Start all CockroachDB nodes, HAProxy and run cluster init
    stop            Stop all containers (preserves data)
    start           Start previously stopped containers
    down            Tear down containers and delete all data volumes

  Observability:
    ps              Show container status
    logs            Show logs (all containers)
    logsf           Follow logs (all containers)
    watch           Watch container status (refreshes every 2s)

  SQL:
    crsql           Open interactive SQL shell via HAProxy
    create-bank     Execute sql/create_bank.sql via HAProxy (creates bank db + accounts table)

  Workloads:
    load-movr       Load the MovR dataset into the cluster via HAProxy
    run-movr        Run the MovR workload for 5 minutes via HAProxy

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


# ---------------------------------------------------------------------------
# Cluster Lifecycle
# ---------------------------------------------------------------------------

run:
	@echo "🚀 Starting CockroachDB cluster and HAProxy..."
	docker compose -f docker-compose.yml -p cockroach up -d \
		roach1 roach2 roach3 roach4 roach5 roach6 \
		haproxy roach-init \
		--remove-orphans

stop:
	docker compose -f docker-compose.yml -p cockroach stop

start:
	docker compose -f docker-compose.yml -p cockroach start

down:
	@echo "🛑 Tearing down cluster and removing data..."
	docker compose -f docker-compose.yml -p cockroach down
	cd data && rm -rf roach1 roach2 roach3 roach4 roach5 roach6


# ---------------------------------------------------------------------------
# Observability
# ---------------------------------------------------------------------------

ps:
	docker compose -f docker-compose.yml -p cockroach ps

logs:
	docker compose -f docker-compose.yml -p cockroach logs

logsf:
	docker compose -f docker-compose.yml -p cockroach logs -f

watch:
	watch docker compose -f docker-compose.yml -p cockroach ps


# ---------------------------------------------------------------------------
# SQL
# ---------------------------------------------------------------------------

crsql:
	@echo "🔌 Connecting to CockroachDB via HAProxy..."
	docker exec -it roach1 ./cockroach sql --insecure --host=haproxy:26000

# Manually Execute script - Example
create-bank:
	@echo "🏦 Executing sql/create_bank.sql via HAProxy..."
	docker exec -it roach1 ./cockroach sql --insecure --host=haproxy:26000 \
		--file=/cockroach/sql/create_bank.sql


# ---------------------------------------------------------------------------
# Workloads
# ---------------------------------------------------------------------------

load-movr:
	@echo "📦 Loading MovR dataset via HAProxy..."
	docker exec -it roach1 ./cockroach workload init movr \
		'postgresql://root@haproxy:26000?sslmode=disable'

run-movr:
	@echo "⚡ Running MovR workload for 5 minutes via HAProxy..."
	docker exec -it roach1 ./cockroach workload run movr --duration=5m \
		'postgresql://root@haproxy:26000?sslmode=disable'