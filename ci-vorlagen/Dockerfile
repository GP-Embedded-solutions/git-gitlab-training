FROM python:3.12-slim
WORKDIR /app
COPY src/ src/
CMD ["python", "-c", "from src.calc import add, power; print('calc-service ok:', add(2, 3), power(2, 10))"]
