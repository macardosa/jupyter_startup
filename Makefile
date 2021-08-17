OS := $(shell uname -s)

all: build install start test
	@echo "Now JupyterLab will be run at startup as a system daemon."
	@echo "JupyterLab is reachable any time pointing your browser to http://localhost:8888/lab"
	@echo "JupyterNotebook is reachable any time pointing your browser to http://localhost:8888/tree"

build:
ifeq ($(OS),Darwin)
	@python build_service.py macOS
else
	@python build_service.py linux
endif

install:
ifeq ($(OS),Darwin)
	@cp jupyter.plist $(HOME)/Library/LaunchAgents/
	@mkdir -p $(HOME)/.jupyter/
	@cp startup.sh $(HOME)/.jupyter/
	@chmod +x $(HOME)/.jupyter/startup.sh
else
	@sudo cp jupyter.service /usr/lib/systemd/system/
endif

uninstall:
ifeq ($(OS),Darwin)
	@rm -f $(HOME)/Library/LaunchAgents/jupyter.plist
	@rm -f $(HOME)/.jupyter/startup.sh
else
	@sudo rm -f /usr/lib/systemd/system/jupyter.service
endif

start:
ifeq ($(OS),Darwin)
	@launchctl load ~/Library/LaunchAgents/jupyter.plist
else
	@sudo systemctl enable jupyter.service
	@sudo systemctl daemon-reload
	@sudo systemctl restart jupyter.service
endif

stop:
ifeq ($(OS),Darwin)
	@launchctl unload ~/Library/LaunchAgents/jupyter.plist
else
	@sudo systemctl stop jupyter.service
endif

test:
ifeq ($(OS),Darwin)
	@open http://localhost:8888/lab
else
	@xdg-open http://localhost:8888/lab
endif

clean:
ifeq ($(OS),Darwin)
	@rm -f jupyter.plist startup.sh
else
	@rm -f jupyter.service
endif


.PHONY: install stop start all test


