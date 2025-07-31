# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set environment variables to prevent Python from writing .pyc files to disk
# and to ensure we run the app in production mode
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements.txt /app
COPY ./requirements.txt /app/requirements.txt
# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the app code to the container
COPY . /app

# Expose the port the app runs on
EXPOSE 5000

ENV FLASK_APP=/app/app.py

# Run Gunicorn as the entrypoint, use 4 workers and bind it to the container's IP
CMD ["flask", "run", "-h", "0.0.0.0", "-p", "5000"]
