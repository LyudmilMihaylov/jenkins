# Use a base image with Python pre-installed
FROM python:3.8-slim

# Install virtualenv
RUN apt-get update && apt-get install -y python3-venv

# Create a virtual environment and install dependencies
RUN python3 -m venv /env
RUN /env/bin/pip install flask==2.0.3 requests==2.32.3

# Set the working directory
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Run the app using the virtual environment
CMD ["/env/bin/python", "app.py"]
