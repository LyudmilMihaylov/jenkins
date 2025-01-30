# Use the Python 3.6-slim image
FROM python:3.6-slim

# Install pip (in case it's missing) and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && curl https://bootstrap.pypa.io/get-pip.py | python3

# Set the working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install the dependencies defined in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 to access the app
EXPOSE 5000

# Set the default command to run the Flask app
CMD ["python", "app.py"]
