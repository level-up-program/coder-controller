# Clean out team folders
clean:
	rm -r levelup/docker-volumes

# Setup for ec2 - assumes sudo bash with yum install docker git already run
bootstrap_ec2:
	service docker start
	python3 -m pip install docker-compose
	export PATH=$PATH:/bin:/bin/docker-compose

# Create shared directories
bootstrap:
	mkdir -p levelup/docker-volumes
	mkdir -p levelup/.m2/repository
	python3 -m pip install pyyaml
	python3 -m pip install docker-compose
	docker pull ghcr.io/jpwhite3/polyglot-code-server:latest

# Create docker compose - set NUM_TEAMS equal to the number of container to generate
compose: bootstrap
	python3 docker-compose-composer.py $(NUM_TEAMS)

# example: make start NUM_TEAMS = 3 
start: compose
	docker-compose up -d --remove-orphans

stop:
	docker-compose stop