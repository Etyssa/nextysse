# -----------------------------------------------------------------------------
# Author : Edouard Richard                                  <edou4rd@gmail.com>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
PROJECT_NAME = "Seminaire2014"
RM           = rm -fr
MV           = mv -f
DIST_DIR     = "dist/"
TIMESTAMP    = $(shell date "+%Y-%m-%d")
GRUNT        = grunt
BOWER        = bower
NPM          = npm

run: clean
	$(GRUNT) serve

clean:
	$(GRUNT) clean
	$(RM) $(CACHE)

install:
	$(NPM) install
	$(BOWER) install
	@echo "installed"

freeze: clean
	$(RM) $(DIST_DIR) -r
	$(GRUNT) build
	@echo "freezed in $(DIST_DIR)"

archive: freeze
	@cp -r $(DIST_DIR) $(PROJECT_NAME)-$(TIMESTAMP)
	@tar cvjf "$(PROJECT_NAME)-$(TIMESTAMP).tar.bz2" "$(PROJECT_NAME)-$(TIMESTAMP)"
	@rm -rf $(PROJECT_NAME)-$(TIMESTAMP)
	@echo "archive $(PROJECT_NAME)-$(TIMESTAMP).tar.bz2 created"

# EOF
