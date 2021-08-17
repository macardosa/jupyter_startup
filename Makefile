OS := $(shell uname -s)

all: install load test
	@echo "Now JupyterLab will be run at startup as a system daemon."
	@echo "JupyterLab is reachable any time pointing your browser to http://localhost:8888/lab"
	@echo "JupyterNotebook is reachable any time pointing your browser to http://localhost:8888/tree"

install:
ifeq ($(OS),Darwin)
	@cp jupyter.plist $(HOME)/Library/LaunchAgents/
	@mkdir -p $(HOME)/.jupyter/
	@cp startup.sh $(HOME)/.jupyter/
	@chmod +x $(HOME)/.jupyter/startup.sh
endif

load:
ifeq ($(OS),Darwin)
	@launchctl load ~/Library/LaunchAgents/jupyter.plist
endif

unload:
ifeq ($(OS),Darwin)
	@launchctl unload ~/Library/LaunchAgents/jupyter.plist
endif

test:
ifeq ($(OS),Darwin)
	@open http://localhost:8888/lab
else
	@xdg-open http://localhost:8888/lab
endif

.PHONY: install unload load all test


