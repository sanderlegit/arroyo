.PHONY: build
build: postgres-up migrations webui-build
	cargo build --package arroyo

run: build
	target/debug/arroyo cluster

.PHONY: postgres-up
postgres-up:
	cd docker && docker compose up -d

.PHONY: postgres-down
postgres-down:
	cd docker && docker compose down

.PHONY: install-refinery
install-refinery:
	cargo install refinery_cli
	
.PHONY: migrations
migrations:
	refinery migrate -c ./docker/refinery.toml -p crates/arroyo-api/migrations

webui-build:
	cd webui && pnpm install && pnpm build
