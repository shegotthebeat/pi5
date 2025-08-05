#!/bin/bash

echo "Starting csvboxer app..."
cd /home/hookworm/csvboxer
source venv/bin/activate
pip install requirements.txt
export FLASK_APP=csvboxer.py
flask run --host=0.0.0.0 --port=5000 &
deactivate

echo "Starting filer app..."
cd /home/hookworm/filer
source venv/bin/activate
pip install requirements.txt
export FLASK_APP=filer.py
flask run --host=0.0.0.0 --port=5001 &
deactivate

echo "Both Flask apps have been started in the background."
echo "Use 'jobs' to see them. Use 'fg 1' or 'fg 2' to bring them to the foreground."
