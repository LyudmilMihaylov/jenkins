# Use Python 3.6 or later as a base image
FROM python:3.6-slim

# Set the working directory inside the container
WORKDIR /app

# Copy contents into image
COPY . /app

# Install pip dependencies from requirements
RUN pip install --no-cache-dir -r requirements.txt

# Set YOUR_NAME environment variable
ENV YOUR_NAME="Lyudmil Mihaylov"

# Expose the correct port (assuming your app runs on port 5000)
EXPOSE 5000

# Create an entrypoint
ENTRYPOINT ["python"]
CMD ["app.py"]
