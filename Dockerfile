# Get OS
FROM alpine:3.14

# Create Folder App inside our OS Alpine
WORKDIR /app

# Copy Our shell script to WORKDIR
COPY returns_processor.sh input/* ./

# Give permission to shell script
RUN chmod +x returns_processor.sh

# Run Our Script
RUN source ./returns_processor.sh
