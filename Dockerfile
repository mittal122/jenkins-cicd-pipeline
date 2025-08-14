FROM python:3.11-slim

WORKDIR /app

# Install system deps if needed (psycopg2, etc.)
# RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

# Speed up installs and ensure repeatability
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# If you have requirements.txt, prefer it:
# COPY requirements.txt .
# RUN pip install --upgrade pip && pip install -r requirements.txt

# If not using requirements.txt:
RUN pip install --upgrade pip && pip install django==3.2

COPY . .

# Do NOT run migrations at build time; run at container start
# EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
