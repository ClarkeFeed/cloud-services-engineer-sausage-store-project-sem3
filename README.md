# Проект "Cloud Services Engineer Docker Project Sem2"

**Краткое описание**  
Учебный проект по курсу "Cloud Services Engineer", магазин пельменей "Момо". Он демонстрирует сборку и оркестрацию микросервисов с помощью Docker Compose. В составе проекта:

- **backend** — микросервис на Go, реализующий REST-API.
- **frontend** — приложение на Vue.js + TypeScript.

---

## Содержание

1. [Технологии](#технологии)
2. [Требования](#требования)  
3. [Установка и запуск](#установка-и-запуск)
4. [Оптимизация](#оптимизация)
---

## Технологии

- **Go** (backend)
- **Vue.js + TypeScript + Nginx** (frontend)
- **Docker** & **Docker Compose**

- **Frontend** – TypeScript, Angular.
- **Backend**  – Java 16, Spring Boot, Spring Data.
- **Database** – H2.
- **Infrastructure** - Yandex Cloud
- **IaC** - Ansible, Terraform
- **CI/CD** - Gitlab-CI

---

## Требования

- **Docker >= 20.10**
- **Docker Compose >= 1.29**
- **Git**

---

## Установка и запуск

0. Подготовьте ssh-ключи для Terraform и Ansible а также необходимые переменные.
```bash
terraform init --upgrade && terrafrom apply

ansible-playbook vault-playbook.yml
```

После успешного запуска нужно выполнить:
```bash
kubectl --kubeconfig kubeconfig -n <namespace> exec -it mongodb-0 -- bash

mongosh --username ${MONGO_INITDB_ROOT_USERNAME} --password ${MONGO_INITDB_ROOT_PASSWORD} --authenticationDatabase admin --eval "
            db = db.getSiblingDB('${MONGO_REPORTS_DATABASE}');
            db.createUser({
              user: '${MONGO_REPORTS_USERNAME}',
              pwd: '${MONGO_REPORTS_PASSWORD}',
              roles: [{ role: 'readWrite', db: '${MONGO_REPORTS_DATABASE}' }]
            });
          "
```

1. Клонировать репозиторий
```bash
git clone https://github.com/ClarkeFeed/cloud-services-engineer-docker-project-sem2.git
cd cloud-services-engineer-docker-project-sem2
```

2. Запустить проект со сборкой
```bash
docker-compose up --build -d
```

3. Проверить запущенные контейнеры
```bash
docker ps
```

После успешного запуска должны быть доступны:
- Frontend: http://localhost(:80)
- Backend: http://localhost:8081

## Оптимизация

Для уменьшения веса образов в сборке использовались следующие приёмы:
1. alpine образы;
2. multi-stage build;
3. добавлен .dockerignore;
4. флаг `CGO_ENABLED=0` для backend;
5. флаги `--no-audit --no-fund` для frontend.

Это позволяет не пересобирать зависимости при каждом изменении исходного кода, .dockerignore позволяет исключить добавления ненужных файлов при сборке.

Для nginx был настроен gzip и Cache-Control для кеширования и уменьшения размера передаваемых файлов.