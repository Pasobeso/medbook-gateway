clone-services:
	cd services && git clone https://github.com/Pasobeso/medbook-userservice.git
	
update-services:
	cd services/medbook-userservice && git pull
	