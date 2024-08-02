# Use the official Python image from the Docker Hub
FROM python:3.10-slim

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY "requirements.txt" requirements.txt

# Install system dependencies and Python dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget -qO - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable unzip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ChromeDriver
RUN wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip

# Set environment variables for ChromeDriver
ENV CHROMEDRIVER_PATH=/usr/local/bin/chromedriver

# Copy the entire project into the container
COPY . .

# Expose the port for the web server
EXPOSE 5000

# Define the command to run the application
CMD ["python", "Data Scraping/src/scrape_ww.py"]
