# Cloud Foundation Fabric (CFF) Tools

This directory contains utility scripts and tools used to automate linting, formatting, validation, documentation generation, and testing across the Cloud Foundation Fabric repository.

## Categorized Tools

### 1. Documentation Generation
Tools for automatically generating documentation tables or formats from source configurations.

- **[tfdoc.py](./tfdoc.py)**: Generates variable, output, optional file, fixture, and recipe documentation for Terraform module READMEs, plus a table of contents.
- **[schema_docs.py](./schema_docs.py)**: Recursively parses and compiles JSON schemas into readable, markdown-based documentation tables.
- **[update_schema_links.py](./update_schema_links.py)**: Updates the schema URLs in YAML modelines across a directory to match a specific CDN or versioned source.
- **[pre-commit-tfdoc.sh](./pre-commit-tfdoc.sh)**: Pre-commit hook script to run `tfdoc.py` updates and verify README alignment.

### 2. Linting, Quality & Compliance
Tools for maintaining style guide compliance, licensing, validation, and content/rule verification.

- **[check_boilerplate.py](./check_boilerplate.py)**: Scans files to verify that correct Google license headers and boilerplates are present.
- **[check_documentation.py](./check_documentation.py)**: Recursively verifies that the variables and outputs tables generated inside module `README.md` files are up-to-date.
- **[check_links.py](./check_links.py)**: Recursively parses Markdown files to validate external links, internal links, and anchor destinations.
- **[check_schema_docs.py](./check_schema_docs.py)**: Recursively checks if the Markdown documentation generated from JSON schemas is fully up-to-date.
- **[check_yaml_schema.py](./check_yaml_schema.py)**: Validates YAML configuration and factory data files against their defined JSON schema modelines.
- **[lint.sh](./lint.sh)**: A shell script wrapping boilerplate, YAML, and Terraform style and format checks.
