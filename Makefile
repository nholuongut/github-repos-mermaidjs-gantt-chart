#
#  Author: Nho Luong
#  Date: 2016-01-17 12:56:53 +0000 (Sun, 17 Jan 2016)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/nholuongut/gitHub-repos-mermaidjs-ggantt-chart
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/nholuong
#

# ===================
# bootstrap commands:

# setup/bootstrap.sh
#
# OR
#
# Alpine:
#
#   apk add --no-cache git make && git clone https://github.com/nholuongut/gitHub-repos-mermaidjs-ggantt-chart repo && cd repo && make
#
# Debian / Ubuntu:
#
#   apt-get update && apt-get install -y make git && git clone https://github.com/nholuongut/gitHub-repos-mermaidjs-ggantt-chart repo && cd repo && make
#
# RHEL / CentOS:
#
#   yum install -y make git && git clone https://github.com/nholuongut/gitHub-repos-mermaidjs-ggantt-chart repo && cd repo && make

# ===================

ifneq ("$(wildcard bash-tools/Makefile.in)", "")
	include bash-tools/Makefile.in
endif

REPO := https://github.com/nholuongut/gitHub-repos-mermaidjs-ggantt-chart

CODE_FILES := $(shell git ls-files | grep -E -e '\.sh$$' -e '\.go$$' | sort)

BINARY=github-repos-gantt

.PHONY: default
default:
	@#go run main.go nholuongut
	./run.sh

.PHONY: build
build: init
	@echo ================
	@echo GitHub-Repos-MermaidJS-Gantt-Chart Builds
	@echo ================
	@$(MAKE) git-summary
	@echo
	go build -o "$(BINARY)" main.go

.PHONY: init
init:
	@echo
	@echo "running init:"
	git submodule update --init --recursive
	@echo

.PHONY: install
install: build
	@:

.PHONY: test
test:
	bash-tools/checks/check_all.sh

.PHONY: clean
clean:
	@rm -fv -- $(BINARY)
