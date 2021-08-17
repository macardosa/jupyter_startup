import os
import sys
from string import Template

linux_file = Template(
        '''[Unit]
Description=Jupyter Lab Server
[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=$jupbin/jupyter-lab --config=$home/.jupyter/jupyter_lab_config.py --no-browser
User=$user
Group=$user
WorkingDirectory=$home
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target''')

macOS_plist = Template(
        '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>Label</key>
   <string>jupyter-startup</string>
   <key>ProgramArguments</key>
   <array><string>/Users/$user/.jupyter/startup.sh</string></array>
   <key>RunAtLoad</key>
   <true/>
   <key>StandardOutPath</key>
   <string>/Users/$user/Library/Logs/jupyter.log</string>
   <key>StandardErrorPath</key>
   <string>/Users/$user/Library/Logs/jupyter.log</string>
</dict>
</plist>''')

startup_file = Template(
        '''#!/bin/bash

PATH="$jupbin:$$PATH"

eval "$$(conda shell.bash hook)"
conda activate base

cd ~ && $jupbin/python -m jupyter lab --port 8888 --no-browser''')

if __name__ == '__main__':
    try:
        jupbin = os.path.dirname(sys.executable)
        user = os.getenv('USER')
        home = os.getenv('HOME')
        if sys.argv[1] == 'linux':
            with open('jupyter.service', 'w') as f:
                print(linux_file.substitute(jupbin = jupbin,
                    user = user, home = home), file=f)
        elif sys.argv[1] == 'macOS':
            with open('jupyter.plist', 'w') as f:
                print(macOS_plist.substitute(user = user), file=f)
            with open('startup.sh', 'w') as f:
                print(startup_file.substitute(jupbin = jupbin), file=f)
    except IndexError:
        pass
