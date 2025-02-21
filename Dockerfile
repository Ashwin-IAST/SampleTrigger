# Stage 1: Build for ARM64 architecture
FROM --platform=linux/arm64 alpine:3.18 AS build

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    libgpiod-dev \
    linux-headers \
    git

# Set working directory for the build process
WORKDIR /app

# Copy source code (only the necessary files for building)
COPY src/ ./src/
COPY include/ ./include/

# Compile the program (adjust path based on your project structure)
RUN gcc -I./include -o my_program src/*.c -lgpiod && \
    strip my_program && \
    chmod +x my_program  # Ensure it's executable

# Stage 2: Runtime for ARM64 architecture
FROM --platform=linux/arm64 alpine:3.18

# Set working directory for runtime
WORKDIR /app

# Install runtime dependencies (no need for build dependencies here)
RUN apk add --no-cache libgpiod

# Copy the compiled binary from the build stage
COPY --from=build /app/my_program .

# Set the default command to run the program
CMD ["./my_program"]
