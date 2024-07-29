# BLACKSCAN
Teraform to run pentest images in AWS

Please refer to AWS policies https://aws.amazon.com/security/penetration-testing/

1. modify variables.tf
2. terraform init
3. terraform apply
4. aws ecs list-tasks --cluster blackscan
5. aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "/bin/bash"

Contains the following

- nmap (use with caution) 
- wfuzz (quick and dirty appsec stability test)
- trufflehog (useful for passive scanning)
- bearer (useful for passive scanning)

Security Automation

- Build use case automation (eg. Credential(Trufflehog), Bruteforce(wfuzz), Network(Nmap), Application(Bearer), etc.)
- Build to fire and forget use cases (scale and log data)
- Build reporting to identify "real" issues to Slack/JIRA, etc.
