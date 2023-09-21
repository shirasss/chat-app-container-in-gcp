# Set the base image (host OS)
FROM python:3.8

# Set the environment variable for Flask to development mode
ENV FLASK_ENV development

# Set the working directory in the container
WORKDIR /chatApp

# Copy the dependencies file (requirements.txt) to the working directory
COPY requirements.txt .

# Set the timezone environment variable to 'Israel'
ENV TZ 'Israel'

# Install Python dependencies from the requirements.txt file
RUN pip install -r requirements.txt

# Set the data directory environment variable
ENV DATA_DIR='./data/'

# Set the rooms directory environment variable based on DATA_DIR
ENV ROOMS_DIR=${DATA_DIR}'rooms/'

# Add a health check that runs every 10 seconds and times out after 3 seconds
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:5000/health || exit 1

# Copy the content of the local directory to the working directory in the container
COPY . .

# Define the command to run when the container starts
CMD [ "python", "./chatApp.py" ]


