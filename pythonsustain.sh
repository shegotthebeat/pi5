#!/bin/bash

# This script automates the setup of Flask applications as systemd services
# on a Raspberry Pi for persistence after reboot.

echo "Starting Flask systemd service setup..."

# --- Configuration for csvboxer service ---
CSVBOXER_SERVICE_NAME="csvboxer.service"
CSVBOXER_DESCRIPTION="CSVBoxer Flask App"
CSVBOXER_WORKING_DIR="/home/hookworm/csvboxer"
CSVBOXER_EXEC_START="/home/hookworm/csvboxer/venv/bin/flask run --host=0.0.0.0 --port=5000"
CSVBOXER_FLASK_APP="csv-boxer.py"

# --- Configuration for filer service ---
FILER_SERVICE_NAME="filer.service"
FILER_DESCRIPTION="Filer Flask App"
FILER_WORKING_DIR="/home/hookworm/filer"
FILER_EXEC_START="/home/hookworm/filer/venv/bin/flask run --host=0.0.0.0 --port=5001"
FILER_FLASK_APP="src/file_service.py"

# --- Common Service Settings ---
SERVICE_USER="hookworm" # User under which the Flask apps will run

# --- Create csvboxer.service file ---
echo "Creating /etc/systemd/system/${CSVBOXER_SERVICE_NAME}..."
sudo tee "/etc/systemd/system/${CSVBOXER_SERVICE_NAME}" > /dev/null <<EOF
[Unit]
Description=${CSVBOXER_DESCRIPTION}
After=network.target

[Service]
User=${SERVICE_USER}
WorkingDirectory=${CSVBOXER_WORKING_DIR}
ExecStart=${CSVBOXER_EXEC_START}
Environment=FLASK_APP=${CSVBOXER_FLASK_APP}
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo "${CSVBOXER_SERVICE_NAME} created."

# --- Create filer.service file ---
echo "Creating /etc/systemd/system/${FILER_SERVICE_NAME}..."
sudo tee "/etc/systemd/system/${FILER_SERVICE_NAME}" > /dev/null <<EOF
[Unit]
Description=${FILER_DESCRIPTION}
After=network.target

[Service]
User=${SERVICE_USER}
WorkingDirectory=${FILER_WORKING_DIR}
ExecStart=${FILER_EXEC_START}
Environment=FLASK_APP=${FILER_FLASK_APP}
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo "${FILER_SERVICE_NAME} created."

# --- Reload systemd daemon ---
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload
echo "Daemon reloaded."

# --- Enable services to start on boot ---
echo "Enabling ${CSVBOXER_SERVICE_NAME}..."
sudo systemctl enable "${CSVBOXER_SERVICE_NAME}"
echo "${CSVBOXER_SERVICE_NAME} enabled."

echo "Enabling ${FILER_SERVICE_NAME}..."
sudo systemctl enable "${FILER_SERVICE_NAME}"
echo "${FILER_SERVICE_NAME} enabled."

# --- Start services immediately ---
echo "Starting ${CSVBOXER_SERVICE_NAME}..."
sudo systemctl start "${CSVBOXER_SERVICE_NAME}"
echo "${CSVBOXER_SERVICE_NAME} started."

echo "Starting ${FILER_SERVICE_NAME}..."
sudo systemctl start "${FILER_SERVICE_NAME}"
echo "${FILER_SERVICE_NAME} started."

echo "Flask systemd service setup complete. Your Flask apps should now be running and will persist after reboot."
echo "You can check their status with: sudo systemctl status ${CSVBOXER_SERVICE_NAME} and sudo systemctl status ${FILER_SERVICE_NAME}"
