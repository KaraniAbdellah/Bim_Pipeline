# Get OS
FROM alpine:3.14

# Download Packages
RUN apk add --no-cache bash gawk coreutils

# Create Folder App inside our OS Alpine
WORKDIR /app

# Copy Our shell script to WORKDIR
COPY returns_processor.sh input/* ./

# Give permission to shell script
RUN chmod +x returns_processor.sh

# Run shell Script in llop each 10 second
CMD ["sh", "-c", "while true; do ./returns_processor.sh; sleep 10; done"]
