# Check all required tools are accessible
REQUIRED_EXECUTABLES = go gofmt git oc operator-sdk sed yamllint find grep python3
# If we're running e.g. "make docker-build", nothing but docker is required
# because all the above build tools are supposed to be included in the docker
# image.
ifneq (,$(findstring docker-,$(MAKECMDGOALS)))
    REQUIRED_EXECUTABLES = docker
endif
# Don't check for any tool if "make help" is run, "make" is executed without any target or SKIP_TOOLS var is set.
ifneq ($(MAKECMDGOALS),help)
ifneq ($(MAKECMDGOALS),)
ifneq ($(SKIP_TOOLS),)
ifeq ($(VERBOSE),1)
$(info Searching for required executables: $(REQUIRED_EXECUTABLES)...)
endif
K := $(foreach exec,$(REQUIRED_EXECUTABLES),\
        $(if $(shell which $(exec) 2>/dev/null),some string,$(error "ERROR: No "$(exec)" binary found in in PATH!")))
endif
endif
endif