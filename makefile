.PHONY: clean clean_env clean_deployment_package test setup_dev package deploy deploy_app_stack deploy_buckets

#.ONESHELL:
SHELL := /bin/zsh
TEST_PATH:=./
PYTHON:=python3.7
PIP:=pip3.7
VENV = .venv
BIN := $(ENV)/bin
DEPLOY := .deploy_package
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CHECKSUM:=md5

.DEFAULT: help

help:
	@echo "make setup_dev"
	@echo "       prepare development environment"
	@echo "make test"
	@echo "       run tests"

clean: clean_env clean_deployment_package
	rm -rf .pytest_cache
	rm -rf htmlcov
	rm -rf .mypy_cache
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
	find . -type d -name .mypy_cache -delete

clean_env:
	rm -rf $(VENV)
	
clean_deployment_package:
	rm -rf $(DEPLOY) 
	rm -f deploy.zip

setup_dev:
	echo $(ROOT_DIR); \
	$(PYTHON) -m venv $(VENV); \
	. $(ROOT_DIR)/$(VENV)/bin/activate; \
	pip install -r requirements.txt; \
	pip install -r requirements_dev.txt; \
	pip install -r requirements_test.txt; \

test:
	. $(ROOT_DIR)/$(VENV)/bin/activate; \
	pytest -s --cov-report term-missing --cov=src --cov-report html; \

build_docker:
	docker build -t mylambda .
	
package_docker: clean_deployment_package
	docker run -v $(PWD)/:/app mylambda /app/bin/create_package_via_docker.sh

package: clean_deployment_package
	mkdir $(DEPLOY); \
	$(PIP) install -r requirements.txt -t $(DEPLOY); \
	cp -r src/* $(DEPLOY); \
	cd $(DEPLOY); \
	zip -X -r ../deploy.zip ./;\

#upload_package: package
#	aws s3 cp deploy.tar.gz s3://asset2/sss/

deploy: clean deploy_buckets deploy_app_stack

deploy_buckets:
	aws cloudformation deploy --stack-name test-demo1-storage --template ./infra/buckets.yaml

deploy_app_stack: package_docker
	./bin/deploy_app_stack.sh

