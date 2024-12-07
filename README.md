# BLACKSCAN

Docker to run blackscan locally or in coder

1. Modify docker-compose.yml ```blackscan_domain=localhost``` set the target domain here
1. Start blackscan ```docker-compose up -d```
2. Install module ```docker exec -ti blackscan-node-1 blackscan module metasploit```
3. Run playbook ```cd playbooks; ./msf_ssl_scanner```

Teraform to run blackscan in AWS

Please refer to AWS policies https://aws.amazon.com/security/penetration-testing/

1. modify variables.tf
2. ```terraform init```
3. ```terraform apply```
4. ```aws ecs list-tasks --cluster blackscan```
5. ```aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "blackscan moudle nmap"```
6. ```aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "nmap -sC domain.com"```

Install module(s)

- Run on docker ```docker exec -ti blackscan-node-1 blackscan module nmap``` to install nmap module
- Run on AWS ecs ```aws ecs execute-command --cluster blackscan --task <task_id_from_above> --container blackscan --interactive --command "blackscan moudle nmap"``` to install nmap module

  Available modules
  - bearer
  - metasploit
  - nmap
  - nuclei
  - trivy
  - tufflehog
  - wfuzz

Run Playbooks 

- Run playbook on docker ```cd playbooks; ./nmap_scanner```

Standalone Using Modules

- bearer (useful for passive vulnerability scanning aka SAST) - Example ```bearer scan <source>```
- metasploit (usefull to test exploits and provide shell listeners) - Example ```msfconsole -q -x "use auxiliary/scanner/ssl/ssl_version; set RHOST domain.com; exploit; exit"```
- nmap (quick network scanner) ```nmap -sC domain.com```
- nuclei (vulnerability scanner aka DAST) ```nuclei -target domain.com``` 
- trivy (container scanner for vulnerabilites and SBOM) ```trivy image blackopsinc/blackscan:latest```
- trufflehog (useful for passive credential scanning) - Example ```trufflehog git https://github.com/blackopsinc/BLACKSCAN```
- wfuzz (quick and dirty subdomain scanner and parameter fuzzing) - Example ```wfuzz -c -Z -w /security/subdomains.txt --sc 200 https://FUZZ.domain.com```

Security Automation

- Build use case automation (eg. Credential(Trufflehog), Bruteforce(wfuzz), Network(Nmap), Application(Bearer), etc.)
- Build to fire and forget use cases (scale and log data)
- Build reporting to identify "real" issues to Slack/JIRA, etc.
