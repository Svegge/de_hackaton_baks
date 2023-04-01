# de_hackaton_baks
# Построение DWH для аналитики кликстрима

```
Проект загрузки логов кликстрима действий пользователя на сайте.
С дальнейшим процессом обработки и сохранения в DWH и визуализацией результатов в Metabase
```
### Стек технологий
- postgres
- AirFlow
- Metabase
- Python
- s3 Object Storage
- Bash Linux

### Установленные пакеты apt:
- apt update
- apt unzip

### Установленные пакеты python:
- pip install -r /lessons/requirements.txt

### Структура репозитория
```
Проект декомпозирован по слоям.
В папке /lessons/project функции обработки данных, которые потом подключаем к DAG.

Файловая структура репозитория:
- /lessons/dags - Airflow DAG's проекта
- /lessons/project - файлы проекта
  - /lessons/project/files - исходные файлы
  - /lessons/project/ddl - технические файлы для реализации `ddl `в БД
  - /lessons/project/stg - технические файлы для реализации stg слоя
  - /lessons/project/dds - технические файлы для реализации dds слоя
  - /lessons/project/cdm - технические файлы для реализации cdm слоя
  - /lessons/project/cfg - конфиги проекта

```
### Data WorkFlow
- очистка хранилища сервера
- автоматическая выгрузка из S3 c помощью BashOperator Airflow
- извлечение исходников из архивов было реализовано с помощью утилит unzip