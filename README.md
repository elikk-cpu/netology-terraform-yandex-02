# Terraform: Yandex Cloud infrastructure

Учебный проект по созданию инфраструктуры в Yandex Cloud с помощью Terraform.

## Что создаётся

- Облачная сеть `develop`.
- Подсеть для web-виртуальной машины.
- Подсеть для db-виртуальной машины.
- Две виртуальные машины Ubuntu:
  - `netology-develop-platform-web`;
  - `netology-develop-platform-db`.
- Внешние IP-адреса и выходные параметры виртуальных машин через `terraform output`.

Параметры виртуальных машин, сетей и метаданные задаются переменными Terraform.

## Структура проекта

```text
.
├── README.md
└── src/
    ├── .gitignore
    ├── .terraform.lock.hcl
    ├── console.tf
    ├── locals.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars.example
    ├── variables.tf
    └── vms_platform.tf
```

## Требования

- Terraform версии `1.12.x`.
- Yandex Cloud CLI.
- Сервисный аккаунт в Yandex Cloud с правами, необходимыми для создания сетей и виртуальных машин.
- Файл авторизованного ключа сервисного аккаунта по пути:

  `~/.config/yandex-cloud/authorized_key.json`

- SSH-ключ Ed25519. В Terraform передаётся **публичный** ключ (`.pub`), приватный ключ в репозиторий не добавляется.

## Подготовка

Перейдите в каталог `src`:

```bash
cd src
```

Создайте локальный файл переменных из примера:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Откройте `terraform.tfvars` и укажите:

- `cloud_id` — ID облака;
- `folder_id` — ID каталога;
- свой публичный SSH-ключ в `metadata["ssh-keys"]`.

Пример получения публичного SSH-ключа:

```bash
cat ~/.ssh/id_ed25519.pub
```

Файл `terraform.tfvars` локальный и исключён из Git через `.gitignore`. Не добавляйте в репозиторий приватные ключи, JSON-ключи сервисного аккаунта или файлы состояния Terraform.

## Запуск

Из каталога `src` выполните:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Если план корректен, создайте инфраструктуру:

```bash
terraform apply
```

Для просмотра выходных параметров:

```bash
terraform output
```

## Удаление ресурсов

Когда инфраструктура больше не нужна, удалите созданные Terraform ресурсы:

```bash
terraform destroy
```

Перед подтверждением внимательно проверьте список ресурсов, которые Terraform собирается удалить.

## Примечания

- `terraform.tfvars.example` содержит только пример и не содержит действительных учётных данных.
- `terraform.tfvars`, файлы `terraform.tfstate*`, каталог `.terraform/` и ключи доступа не должны попадать в Git.
- Зоны и доступность платформ виртуальных машин зависят от квот и доступности ресурсов в конкретном облаке.
