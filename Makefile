.PHONY: build
build: postgres-clean postgres-up migrations webui-build
	cargo build --package arroyo

test: postgres-clean postgres-up
	cargo nextest run --no-fail-fast

run: build
	target/debug/arroyo cluster

.PHONY: postgres-up
postgres-up:
	cd docker && docker compose up -d --wait

.PHONY: postgres-down
postgres-down:
	cd docker && docker compose down

.PHONY: postgres-clean
.IGNORE: postgres-clean
postgres-clean: postgres-down
	docker volume rm docker_arroyo_postgres_data && sleep 1

.PHONY: install-refinery
install-refinery:
	cargo install refinery_cli
	
.PHONY: migrations
migrations:
	refinery migrate -c ./docker/refinery.toml -p crates/arroyo-api/migrations

webui-build:
	cd webui && pnpm install && pnpm build
