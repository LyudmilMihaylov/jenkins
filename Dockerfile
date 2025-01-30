# Use a base image with Python pre-installed
FROM python:3.8-slim

# Install Flask 2.0.3 and a compatible version of werkzeug
RUN pip3 install flask==2.0.3 werkzeug==2.0.3 requests==2.32.3

# Set the working directory
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Run the app
CMD ["python3", "app.py"]
