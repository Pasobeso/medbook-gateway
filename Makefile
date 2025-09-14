build-start:
	docker compose up -d --build

start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart 

clone-services:
	cd services && git clone https://github.com/Pasobeso/medbook-userservice.git
	
update-services:
	cd services/medbook-userservice && git checkout main && git pull
	