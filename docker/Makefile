VERSION:=$(shell git describe --tags --dirty --always)
build_image:
	docker build -f Build.Dockerfile \
			--no-cache \
			-t build_ipfs \
			 ../
run_build_image:
	docker run -it --entrypoint /bin/bash build_ipfs
image: 
	docker build --build-arg IFPS_VERSION=$(VERSION) -f Dockerfile \
				-t ipfs \
				-t torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION) \
				-t torplusserviceregistry.azurecr.io/private/ipfs:latest ../
az_pipeline_image:
	docker build --build-arg IFPS_VERSION=$(VERSION) -f Dockerfile_az_pipeline \
				-t ipfs \
				-t torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION) \
				-t torplusserviceregistry.azurecr.io/private/ipfs:latest ../


push: 
	docker push torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION) 
	docker push torplusserviceregistry.azurecr.io/private/ipfs:latest
az_pipeline_push: az_pipeline_image
	docker push torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION)
	docker push torplusserviceregistry.azurecr.io/private/ipfs:latest
clean_up:
	docker rmi --force \
	ipfs \
	torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION) \
	torplusserviceregistry.azurecr.io/private/ipfs:latest \
	torplusserviceregistry.azurecr.io/private/paymentgateway:latest
	docker image prune --force
image_ipfs_haproxy: 
	docker build -f All.Dockerfile \
				-t ipfs_haproxy \
				-t torplusserviceregistry.azurecr.io/private/ipfs_haproxy:$(VERSION) \
				-t torplusserviceregistry.azurecr.io/private/ipfs_haproxy:latest ../
push_ipfs_haproxy: 
	docker push torplusserviceregistry.azurecr.io/private/ipfs_haproxy:$(VERSION) 
	docker push torplusserviceregistry.azurecr.io/private/ipfs_haproxy:latest
fast_image:
	cd ../ && make build_linux
	docker build -f Fast.Dockerfile -t ipfs -t torplusserviceregistry.azurecr.io/private/ipfs:$(VERSION) ../
run_it:
	docker run -it --name ipfs --rm \
		-e PP_ENV=stage \
		-e role=hs_client \
		-p 9051:9051 -p 9050:9050 -p 5001:5001 -p 8080:8080 -p 28080:28080 \
		-v $(PWD)/vol:/opt/paidpiper/vol \
		--entrypoint /bin/bash ipfs
run_it_prod:
	docker run -it --name ipfs --rm \
		-e PP_ENV=prod \
		-e role=hs_client \
		-p 9051:9051 -p 9050:9050 -p 5001:5001 -p 8080:8080 -p 28080:28080 \
		-v $(PWD)/vol:/opt/paidpiper/vol \
		--entrypoint /bin/bash ipfs
run_ipfs_haproxy: 
	docker run -it --name ipfs_haproxy --rm \
		-e PP_ENV=prod \
		-e role=hs_client \
		--rm \
		-p 9051:9051 -p 9050:9050 -p 8080:8080 -p 28080:28080 \
		-v $(PWD)/vol:/opt/paidpiper/vol \
		--entrypoint /bin/bash ipfs_haproxy:latest
dockerlines:
	cd ../ && find . -name 'go.mod' | xargs -I {} echo COPY {} {}
	cd ../ && find . -name 'go.sum' | xargs -I {} echo COPY {} {}
attach:
	docker exec -it ipfs bash

update_config:
	export PP_ENV=stage
	./update.config.sh

update_config_prod:
	export PP_ENV=prod
	sh ./update.config.sh
