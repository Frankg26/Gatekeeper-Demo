install: ## Install tools (MacOS or Linux). Make sure to move the konstraint executable to correct bin folder.
	brew install go
	brew install opa	
	go install github.com/plexsystems/konstraint@latest 
	brew install gator	

test: ## Run rego unit tests.
	opa test opa -v

template: ## Generate ConstraintTemplates and Constraints.
	konstraint create opa --output yaml

gator: ## Run gator test suite.
	gator verify ./...