# -----------------------------------------------------------------------------
# Author : Edouard Richard                                  <edou4rd@gmail.com>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
PROJECT_NAME = "Seminaire2014"
RM           = rm -fr
MV           = mv -f
DEBUG        = True
HOST         = "http://localhost:9000"
DIST_DIR     = "dist/"
TIMESTAMP    = $(shell date "+%Y-%m-%d")
GRUNT        = grunt

run: clean
	$(GRUNT) serve

clean:
	$(GRUNT) clean
	$(RM) $(CACHE)

install:
	virtualenv venv --no-site-packages --distribute --prompt=$(PROJECT_NAME)
	. `pwd`/.env ; pip install -r requirements.txt
	. `pwd`/.env ; npm install
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
