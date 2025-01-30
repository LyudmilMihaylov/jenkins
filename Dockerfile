# Use a base image with Python pre-installed
FROM python:3.8-slim

# Install system dependencies for Flask and Requests (using apt)
RUN apt-get update && apt-get install -y \
    python3-flask \
    python3-requests \
    && rm -rf /var/lib/apt/lists/*  # Clean up apt cache

# Set the working directory
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Run the app
CMD ["python3", "app.py"]
