# -----------------------------------------------------------------------------
# Helper-Lib zum Anzeigen von Applikation-URLs
# -----------------------------------------------------------------------------

# Usage:
#     help: ## show all the mobiad urls
#	      $(call print_mobiad_urls)
define print_mobiad_urls
	@echo "    KeyCloak:           ${BLUE}https://auth.mobiad.io/${NC}"
	@echo
	@echo "    MobiAd:             ${BLUE}https://host.mobiad.io/${NC}"
	@echo "    MobiAd-Version:     ${BLUE}https://host.mobiad.io/api/v1/state/system${NC}"
	@echo "    MobiAd-Config:      ${BLUE}https://host.mobiad.io/api/v1/state/settings${NC}"
	@echo
	@echo "    MobiCharts:         ${BLUE}https://mobicharts.mobiad.io/${NC}"
	@echo "    MobiCharts-Version: ${BLUE}https://mobicharts.mobiad.io/static/app.json${NC}"
	@echo "    MobiCharts-Config:  ${BLUE}https://mobicharts.mobiad.io/config${NC}"
endef
