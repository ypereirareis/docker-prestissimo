compose=docker-compose

build:
	@echo "== Build"
	@docker build -t ypereirareis/prestissimo .

build-no-cache:
	@echo "== Build no cache"
	@docker build -t ypereirareis/prestissimo --no-cache .
