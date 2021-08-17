import os
import sys
from string import Template

linux_file = Template(
        '''[Unit]
Description=Jupyter Notebook
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

if __name__ == '__main__':
    try:
        jupbin = os.path.dirname(sys.executable)
        user = os.getenv('USER')
        home = os.getenv('HOME')
        if sys.argv[1] == 'linux':
            with open('jupyter.service', 'w') as f:
                print(linux_file.substitute(jupbin = jupbin,
                    user = user, home = home), file=f)
    except IndexError:
        pass
