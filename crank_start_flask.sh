#!/bin/bash

# --- Configuration ---
APP_CSV_DIR="/home/hookworm/app-csv"
APP_FILER_DIR="/home/hookworm/app-filer"
APP_CSV_SERVICE_NAME="flask-csvboxer.service"
APP_FILER_SERVICE_NAME="flask-filer.service"
APP_CSV_PORT=5000
APP_FILER_PORT=5001

# --- Function to setup a single Flask app ---
setup_flask_app() {
    local app_dir=$1
    local app_name=$2
    local app_port=$3
    local service_name=$4
    local python_app_file=$5 # e.g., app.py
    local flask_app_object=$6 # e.g., app (the Flask instance name)

    echo "----------------------------------------"
    echo "Setting up ${app_name} app in ${app_dir}..."

    # 1. Create directory if it doesn't exist
    if [ ! -d "$app_dir" ]; then
        echo "Creating directory: ${app_dir}"
        mkdir -p "$app_dir"
    else
        echo "Directory ${app_dir} already exists."
    fi
    cd "$app_dir" || { echo "Failed to change directory to ${app_dir}"; exit 1; }

    # 2. Create virtual environment if it doesn't exist
    if [ ! -d "venv" ]; then
        echo "Creating virtual environment for ${app_name}..."
        python3 -m venv venv
    else
        echo "Virtual environment for ${app_name} already exists."
    fi

    # 3. Activate the virtual environment and install dependencies
    echo "Activating venv and installing dependencies for ${app_name}..."
    source venv/bin/activate

    pip install gunicorn

    # Check if requirements.txt exists before trying to install
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    else
        echo "No requirements.txt found in ${app_dir}. Skipping."
    fi

    deactivate
    echo "Python environment setup for ${app_name} complete."

    # 4. Create Systemd Service File
    echo "Creating systemd service file for ${app_name} (${service_name})..."
    sudo bash -c "cat <<EOF > /etc/systemd/system/${service_name}
[Unit]
Description=Gunicorn instance for ${app_name} Flask App
After=network.target

[Service]
User=pi
Group=www-data
WorkingDirectory=${app_dir}
ExecStart=${app_dir}/venv/bin/gunicorn --workers 3 --bind 0.0.0.0:${app_port} ${python_app_file}:${flask_app_object}
Restart=always

[Install]
WantedBy=multi-user.target
EOF"
    echo "Systemd service file created."

    echo "${app_name} setup complete."
}

# --- Main Execution ---

# Setup csvboxer app
setup_flask_app "$APP_CSV_DIR" "csvboxer" "$APP_CSV_PORT" "$APP_CSV_SERVICE_NAME" "app.py" "csvboxer_app_instance"

# Setup filer app
setup_flask_app "$APP_FILER_DIR" "filer" "$APP_FILER_PORT" "$APP_FILER_SERVICE_NAME" "app.py" "filer_app_instance"

echo "----------------------------------------"
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Enabling and starting services..."
sudo systemctl enable "$APP_CSV_SERVICE_NAME"
sudo systemctl start "$APP_CSV_SERVICE_NAME"
sudo systemctl enable "$APP_FILER_SERVICE_NAME"
sudo systemctl start "$APP_FILER_SERVICE_NAME"

echo "----------------------------------------"
echo "Deployment complete! Check service status:"
sudo systemctl status "$APP_CSV_SERVICE_NAME" --no-pager
sudo systemctl status "$APP_FILER_SERVICE_NAME" --no-pager

echo "Your Flask apps should now be running and configured to restart automatically on power loss. 🎉"
echo "You can access csvboxer at http://<YourPiIP>:${APP_CSV_PORT}"
echo "You can access filer at http://<YourPiIP>:${APP_FILER_PORT}"
