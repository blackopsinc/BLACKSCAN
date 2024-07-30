# BLACKSCAN
Teraform to run pentest images in AWS

Please refer to AWS policies https://aws.amazon.com/security/penetration-testing/

1. modify variables.tf
2. terraform init
3. terraform apply
4. aws ecs list-tasks --cluster blackscan
5. aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "/bin/bash"

Contains the following

- nmap (use with caution) ```nmap -sC domain.com```
- wfuzz (quick and dirty appsec stability test) - Example ```wfuzz -c -Z -w subdomains.txt --sc 200 https://FUZZ.domain.com```
- trufflehog (useful for passive scanning) - Example ```trufflehog git https://github.com/blackopsinc/BLACKSCAN```
- bearer (useful for passive scanning) - Example ```bearer scan https://github.com/blackopsinc/BLACKSCAN```

Security Automation

- Build use case automation (eg. Credential(Trufflehog), Bruteforce(wfuzz), Network(Nmap), Application(Bearer), etc.)
- Build to fire and forget use cases (scale and log data)
- Build reporting to identify "real" issues to Slack/JIRA, etc.
