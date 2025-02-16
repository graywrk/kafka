#!/bin/bash

# Создание виртуального окружения
python3 -m venv .venv

# Активация виртуального окружения
source .venv/bin/activate

# Обновление pip
pip install --upgrade pip

# Установка зависимостей
pip install -r requirements.txt 