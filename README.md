# Project Fleet Provisioning Suite

Orchestrate Google Cloud resource hierarchies through automated identity-driven deployment. 

### Implementation Sequence
0. **Identity Preparation**: Finalize Workspace user creation; upload the resulting identity CSV to the cloned repository root.
1. **Environment Bootstrapping**: Execute `setup0_bootstrap.sh` to dynamically capture Organization identifiers and manifest Folder Creator entitlements.
2. **Configuration Audit**: Verify `config.sh` parameters; ensure `CSV_FILE` accurately references your uploaded identity source.
3. **Execution Pipeline**: Apply executable permissions via `chmod +x setup*.sh` and progress through sequential scripts to realize folder structures, propagate IAM inheritance, and establish billing linkages.

### Execution
```bash
chmod +x *.sh
./setup0_bootstrap.sh  # Establish permissions
./setup1_folder.sh     # Manifest folder
./setup2_folder_iam.sh # Propagate access
./setup3_projects.sh   # Provision fleet
./setup4_billing.sh    # Realize billing
