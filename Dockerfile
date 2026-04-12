FROM python:3.9-slim-buster

# منع التفاعل أثناء التثبيت
ARG DEBIAN_FRONTEND=noninteractive

# تثبيت متطلبات النظام والميديا (وحل مشكلة lxml و Wand)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    ffmpeg \
    mediainfo \
    unzip \
    wget \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libmagickwand-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# تحديد مسار العمل
WORKDIR /app

# نسخ كافة ملفات السورس إلى داخل الحاوية
COPY . .

# تحديث pip وتثبيت المكتبات المطلوبة من ملف requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# أمر التشغيل الأساسي للموديول JoKeRUB
CMD ["python3", "-m", "JoKeRUB"]
