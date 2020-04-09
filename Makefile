#
# gfe: git fetch script
# https://github.com/lptstr/gfe
#
# (c) Kiëd Llaentenn
# See the COPYING file for more information
#

.POSIX:

CMD     =

PREFIX  = /usr/local
DESTDIR =

BIN     = gfe
OBJDIR  = bin

CHMOD   = $(shell which chmod)
RM      = $(shell which rm)
INSTALL = $(shell which install)
M4      = $(shell which m4)

all: bin/$(BIN)

clean:
	$(CMD)$(RM) -rf $(OBJDIR)

$(OBJDIR):
	$(CMD)mkdir -p $(OBJDIR)

$(OBJDIR)/$(BIN): $(OBJDIR) src/$(BIN).m4
	cd src && \
		$(CMD)$(M4) $(BIN).m4 > ../$(OBJDIR)/$(BIN)
	$(CMD)$(CHMOD) +x $(OBJDIR)/$(BIN)

run:
	@$(OBJDIR)/$(BIN)

install: $(OBJDIR)/$(BIN)
	$(CMD)$(INSTALL) -Dm755 $(OBJDIR)/$(BIN) \
		$(DESTDIR)/$(PREFIX)/bin/$(BIN)

uninstall:
	$(CMD)$(RM) -f $(DESTDIR)/$(PREFIX)/bin/$(BIN)

.PHONY: all clean run install uninstall
