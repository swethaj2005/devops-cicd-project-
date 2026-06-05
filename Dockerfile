# ■■ Stage 1: builder ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
FROM python:3.11-slim AS builder
WORKDIR /app
# Copy only requirements first (better layer caching)
COPY requirements.txt .
# Install dependencies into a custom directory
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
# ■■ Stage 2: final production image ■■■■■■■■■■■■■■■■■■■
FROM python:3.11-slim
WORKDIR /app
# Copy installed packages from builder stage
COPY --from=builder /install /usr/local
# Copy application source code
COPY app/ ./app/
# Don't run as root (security best practice)
RUN useradd -m appuser
USER appuser
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app.main:app"]
