#!/bin/bash

PATH="/opt/miniconda3/bin:$PATH"

eval "$(conda shell.bash hook)"
conda activate base

cd ~ && /opt/miniconda3/bin/python -m jupyter lab --port 8888 --no-browser
