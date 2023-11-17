docker-jenkins-master-run:
	sudo chmod 777 /var/run/docker.sock
	sudo docker run -d \
 	--name jenkins \
	--user root \
	-p 8080:8080 \
	-p 50000:50000 \
	-v jenkins_home:/var/jenkins_home \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(which docker):/usr/bin/docker \
	jenkins/jenkins:2.414.3-jdk17

docker-jenkins-master-start:
	sudo chmod 777 /var/run/docker.sock
	sudo docker start jenkins

docker-jenkins-slave-run:
	sudo chmod 777 /var/run/docker.sock
	sudo docker run -d \
	--user root \
	-v jenkins_home:/var/jenkins_home \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(which docker):/usr/bin/docker \
	--name=agent01 \
	--publish 2200:22 \
	-e "JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB/KkKWnin9yTXWK3fpjVPKmoC9yJHdLo5+Zo7Vbb/3VZP/XfX2lGli1VuSnLgi+KQnnIWx0nuogAV/bL6dnAo2MS9C3Djr178O1WdYaK9rsvba+kDLysdeNl+RZnH7mEZRhGqr+kChr7zEIosV9hC95qTbZKTZs8q5ctY8oqYsq8M6Dpa8Nu2t858QXVUWkjwDki+OysoCBO9Tr+a/FUeKaWvSXYqFyndxoRv9CGAmPepyzwCGR2vPBmdUqDkcZQLzgVzdt3W4o7L8cZ1fdd4hU5MBHObBBQw9l04XfZxYB/56O/rFCjiG32LehEyBFCcbXBnHZG87RQ99+weQBVtJfNAvYa1PLMWJozE4YEl43zKXYez3fGdH/t/aBOp4B78sgvFAgNXrpzA40CKzRZXfp5ytHVetM3EBgSNcvN+UCHEIVuepOoQXzpKcsd+RmmdEiDWaEABJFi/romYaJS+1QcYw6aodtVb2oFDVCeDvVIvtJGnEv8pZ5fIMXpmLA0= jenkins@51e4ed65b7a2" \
	jenkins/ssh-agent

docker-jenkins-slave-start:
	sudo chmod 777 /var/run/docker.sock
	sudo docker start agent01
