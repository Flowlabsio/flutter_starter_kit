PROJECT_NAME = <project-name>
ENVIRONMENTS = dev stg prod

create_firebase_project:
	@for env in $(ENVIRONMENTS); do \
		full_project_name=$(PROJECT_NAME)-$$env; \
		echo "Creating Firebase project: $$full_project_name"; \
		firebase projects:create $$full_project_name --non-interactive; \
		if [ $$? -eq 0 ]; then \
			echo "Project $$full_project_name created successfully."; \
		else \
			echo "Error creating project $$full_project_name."; \
		fi; \
	done
	@echo "\n\n\nNow go to Firebase Console and config the services what you want to use!";
