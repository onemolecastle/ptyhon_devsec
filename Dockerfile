# Stage 1: Build
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt . # caching optimisation
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Final Run
FROM python:3.11-slim
WORKDIR /app
RUN ls -la
# Create a non-privileged user
RUN groupadd -g 999 appuser && useradd -r -u 999 -g appuser appuser
COPY --from=builder /root/.local /home/appuser/.local
COPY app.py .
#COPY ..
ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
