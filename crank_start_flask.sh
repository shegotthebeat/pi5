#!/bin/bash

# --- Setup for csvboxer app ---
echo "Setting up and starting csvboxer app..."
cd /home/hookworm/csvboxer

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment for csvboxer..."
    python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Install required packages (e.g., Flask)
echo "Installing dependencies for csvboxer..."
pip install flask
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Set FLASK_APP and run the app in the background
export FLASK_APP=csvboxer.py
echo "Starting csvboxer app on port 5000..."
flask run --host=0.0.0.0 --port=5000 &

# Deactivate the virtual environment
deactivate

# --- Setup for filer app ---
echo "Setting up and starting filer app..."
cd /home/hookworm/filer

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment for filer..."
    python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Install required packages (e.g., Flask)
echo "Installing dependencies for filer..."
pip install flask
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Set FLASK_APP and run the app in the background
export FLASK_APP=filer.py
echo "Starting filer app on port 5001..."
flask run --host=0.0.0.0 --port=5001 &

# Deactivate the virtual environment
deactivate

echo "----------------------------------------"
echo "Both Flask apps have been started in the background. 🎉"
echo "Check their status with 'jobs' or 'ps aux | grep flask'."
