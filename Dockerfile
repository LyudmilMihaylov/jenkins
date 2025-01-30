# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Upgrade pip to avoid any known bugs
RUN pip install --upgrade pip

# Create and activate a virtual environment
RUN python -m venv /env
ENV PATH="/env/bin:$PATH"

# Install Flask, Werkzeug and any additional packages
RUN pip install flask==2.0.3 werkzeug==2.0.3

# Install dependencies from requirements.txt, if it exists
# RUN pip install -r requirements.txt

# Install requests package (for testing)
RUN pip install requests

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define the environment variable to ensure the app runs in production mode
ENV FLASK_ENV=production

# Run the app.py file when the container starts
CMD ["python", "app.py"]
