FROM python:3.10-slim AS builder
WORKDIR /app
COPY requirements.txt . 2>/dev/null || COPY Pipfile . 
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; \
    else pip install pipenv && pipenv install --system --deploy; fi

FROM python:3.10-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY . .
ENV PYTHONUNBUFFERED=1
USER nobody
EXPOSE 9090
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:9090/docs')"
CMD ["python", "app.py"]
