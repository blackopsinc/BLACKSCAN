# BLACKSCAN
Teraform to run pentest images in AWS

1. modify variables.tf
2. terraform init
3. terraform apply
4. aws ecs list-tasks --cluster blackscan
5. aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "/bin/bash"

