# Use a base image with Python pre-installed
FROM python:3.8-slim

# Install pip (if not already installed)
RUN apt-get update && apt-get install -y python3-pip

# Install Flask and Requests via pip
RUN pip3 install flask==2.0.3 requests==2.32.3

# Set the working directory
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Run the app
CMD ["python3", "app.py"]
