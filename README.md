## Local MongoDB Docker Setup

This repository contains scripts and data for setting up a MongoDB instance using Docker and seeding it with example data.

### Contents

- `data` directory: Contains JSON files (`users_data.json`, `products_data.json`, `orders_data.json`) containing collections data in simple and divided versions of database.
- `dockerRun.sh`: Bash script for running MongoDB Docker container and seeding it with example data.
- `app.js`: Example code for checking whether there is a proper connection to the database.

### Instructions

1. Ensure that you have Docker installed on your system.
2. Make sure `dockerRun.sh` has execute permission:
   ```bash
   chmod +x dockerRun.sh
   ```
3. Run the script to start the MongoDB Docker container and seed it with example data:
   - in order to seed simple data run:
   ```bash
   ./dockerRun.sh simple
   ```
   - in order to seed divided data run:
   ```bash
   ./dockerRun.sh divided
   ```
**If running into premission issues try running above commands with sudo.**

### Additional Information

- The MongoDB Docker container runs on port 2717. You can access it via `mongodb://localhost:2717/otx_db`.
