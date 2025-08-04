#!/bin/bash

echo "Starting csvboxer app..."
cd /home/hookworm/app-csv
source venv/bin/activate
export FLASK_APP=csvboxer.py
flask run --host=0.0.0.0 --port=5000 &
deactivate

echo "Starting filer app..."
cd /home/hookworm/app-filer
source venv/bin/activate
export FLASK_APP=filer.py
flask run --host=0.0.0.0 --port=5001 &
deactivate

echo "Both Flask apps have been started in the background."
echo "Use 'jobs' to see them. Use 'fg 1' or 'fg 2' to bring them to the foreground."
