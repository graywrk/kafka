.PHONY: help init-local init-cloud deploy-local deploy-cloud destroy-local destroy-cloud test clean

# Переменные
ANSIBLE_PLAYBOOK = ansible-playbook
VAGRANT = vagrant
TERRAFORM = terraform
MOLECULE = molecule

help:
	@echo "Доступные команды:"
	@echo "  make init-local     - Инициализация локального окружения (Vagrant)"
	@echo "  make init-cloud     - Инициализация облачного окружения (Terraform)"
	@echo "  make deploy-local   - Развертывание на локальном окружении"
	@echo "  make deploy-cloud   - Развертывание в облаке"
	@echo "  make destroy-local  - Удаление локального окружения"
	@echo "  make destroy-cloud  - Удаление облачной инфраструктуры"
	@echo "  make test           - Запуск тестов"
	@echo "  make clean          - Очистка временных файлов"

# Инициализация окружений
init-local:
	./setup_venv.sh
	$(VAGRANT) plugin install vagrant-hostmanager

init-cloud:
	./setup_venv.sh
	cd terraform && $(TERRAFORM) init

# Развертывание
deploy-local:
	$(VAGRANT) up
	$(ANSIBLE_PLAYBOOK) -i inventory.ini playbook.yml

deploy-cloud:
	cd terraform && $(TERRAFORM) apply -auto-approve
	$(ANSIBLE_PLAYBOOK) -i inventory_yandex.ini playbook.yml

# Удаление
destroy-local:
	$(VAGRANT) destroy -f

destroy-cloud:
	cd terraform && $(TERRAFORM) destroy -auto-approve

# Тестирование
test:
	cd roles/kafka && $(MOLECULE) test
	cd roles/kafka_ui && $(MOLECULE) test
	cd roles/clickhouse && $(MOLECULE) test

# Очистка
clean:
	rm -rf .vagrant/
	rm -rf terraform/.terraform/
	rm -rf terraform/terraform.tfstate*
	rm -rf roles/*/molecule/*/tests/__pycache__/
	rm -rf roles/*/.molecule/
	rm -rf .pytest_cache/
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete 