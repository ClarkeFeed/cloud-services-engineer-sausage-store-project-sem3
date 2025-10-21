# Проект "Cloud Services Engineer Sausage Store Project sem3"

# Sausage Store

![image](https://user-images.githubusercontent.com/9394918/121517767-69db8a80-c9f8-11eb-835a-e98ca07fd995.png)

## Install helm-chart
```
helm install sausage-store-chart ./sausage-store-chart --namespace <KUBE_NAMESPACE>
```

## Technologies used

* Frontend – TypeScript, Angular.
* Backend  – Java 16, Spring Boot, Spring Data.
* Database – H2.

## Installation guide
### Backend

Install Java 16 and maven and run:

```bash
cd backend
mvn package
cd target
java -jar sausage-store-0.0.1-SNAPSHOT.jar
```

### Frontend

Install NodeJS and npm on your computer and run:

```bash
cd frontend
npm install
npm run build
npm install -g http-server
sudo http-server ./dist/frontend/ -p 80 --proxy http://localhost:8080
```

Then open your browser and go to [http://localhost](http://localhost)
---

## Содержание

1. [Технологии](#технологии)
2. [Требования](#требования)  
3. [Установка и запуск](#установка-и-запуск)
4. [Оптимизация](#оптимизация)
5. [Переменные](#переменные-окружения-в-cicd-variables)
---

## Технологии

- **Frontend** – TypeScript, Angular.
- **Backend**  – Java 16, Spring Boot, Spring Data.
- **Database** – H2, Postgresql
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

## Переменные окружения в CI/CD variables:
| Переменная              | Описание                                              | Protected | Masked |
|--------------------------|-------------------------------------------------------|------------|---------|
| AUTHORIZED_KEY           | base64-закодированный JSON авторизационного ключа Yandex Cloud | ✅ | ✅ |
| CLOUD_ID                 | Yandex cloud id                                      | ✅ | ✅ |
| DOCKER_PASSWORD          | Пароль DockerHub                                     | ✅ | ✅ |
| DOCKER_USER              | Логин DockerHub                                      | ✅ | ✅ |
| FOLDER_ID                | Yandex folder id                                    | ❌ | ✅ |
| KUBE_CONFIG              | base64 kubeconfig (выдаётся в тренажёре)            | ❌ | ✅ |
| NEXUS_HELM_REPO_URL      | Репозиторий Nexus Yandex                            | ❌ | ✅ |
| NEXUS_PASSWORD           | Пароль Nexus Yandex                                 | ❌ | ✅ |
| NEXUS_USER               | Логин Nexus Yandex                                  | ❌ | ✅ |
| SAUSAGE_STORE_NAMESPACE  | Namespace проекта                                   | ✅ | ✅ |
| SSH_PRIVATE_KEY          | id_rsa \| base64 -w 0                               | ❌ | ✅ |
| SSH_PUBLIC_KEY           | id_rsa.pub                                          | ✅ | ❌ |
| TF_HTTP_PASSWORD         | GitLab Access Token с правами api и read_api        | ✅ | ✅ |
| VAULT_DB_PASSWORD        | Опциональный пароль в Vault для БД                  | ❌ | ✅ |
| VAULT_DB_USERNAME        | Опциональный пользователь в Vault для БД            | ✅ | ❌ |
| VAULT_MONGODB_URI        | Опциональная "ссылка" в Vault для БД                | ❌ | ❌ |
