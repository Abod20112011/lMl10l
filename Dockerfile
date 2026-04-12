FROM python:3.9-slim-buster

# منع التفاعل أثناء التثبيت
ARG DEBIAN_FRONTEND=noninteractive

# تثبيت متطلبات النظام والميديا (بما في ذلك حل مشكلة lxml)
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

# نسخ الملفات وتثبيت مكتبات بايثون مباشرة
COPY . .
RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# أمر التشغيل الأساسي (تأكد أن الملف هو start.py أو عدله حسب موديول سورس جيمثون)
CMD ["python3", "-m", "jepthon"]
