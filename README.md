# jupyter_startup

Scripts and system configurations for running [JupyterLab](https://jupyter.org/) server at startup. This works both for linux and macOS.
In a linux platform a systemd service named *jupyter.service* will be created and lauched conveniently. In macOS a similar service is created, although
using lauchd daemon.
Once installed the service can be conveniently started and stoped in the usual way according to the platform. Namely:

**Linux:**
```bash
systemctl start|stop|restart jupyter.service
```
**macOS:**
```bash
launchctl load|unload ~/Library/LaunchAgents/jupyter.plist
```

## Instructions
```bash
make all
```
A browser window will pop up opening JupypterLab. You can access JupyterLab any time from address http://localhost:8888/lab
(you may add a browser bookmark for it).

To uninstall run:
```bash
make stop
make uninstall
```
and it will delete all the files created in your computer.

----
**NOTE**

In linux you need to have root access, to run lauch systemd commands.

----

## References
- https://jacobtomlinson.dev/posts/2019/how-to-run-jupyter-lab-at-startup-on-macos/
- https://joelzhang.medium.com/setting-up-jupyter-notebook-server-as-service-in-ubuntu-16-04-116cf8e84781
