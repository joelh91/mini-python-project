FROM python:3.11-slim
WORKDIR /folder
COPY . .
RUN pip install -r requirements.txt 
EXPOSE 5000
CMD ["python", "apply.y"]