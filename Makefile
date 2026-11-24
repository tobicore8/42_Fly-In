MAP   ?= maps/easy/01_linear_path.txt

install:
	uv sync

run:
	uv run python fly_in.py $(MAP)

bench:
	@for map in maps/easy/*.txt maps/medium/*.txt maps/hard/*.txt maps/challenger/*.txt; do \
		echo "== $$map"; \
		uv run python fly_in.py $$map; \
	done

debug:
	uv run python -m pdb fly_in.py $(MAP)

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf .mypy_cache .pytest_cache

lint:
	uv run flake8 .
	uv run mypy . --warn-return-any --warn-unused-ignores --ignore-missing-imports \
		--disallow-untyped-defs --check-untyped-defs

lint-strict:
	uv run flake8 .
	uv run mypy . --strict

.PHONY: install run debug clean lint lint-strict bench