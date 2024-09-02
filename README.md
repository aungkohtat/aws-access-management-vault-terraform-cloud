# aws-access-management-vault-terraform-cloud
Management with HCP Vault Integration Using Terraform Cloud, and GitHub Actions

## Create HCP Vault Cluster with Terraform Cloud 

### Terraform Cloud Setup
- terraform version
```
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ terraform version
Terraform v1.9.5
on linux_amd64
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ 
```
- terraform login

![](./images/Screenshot%202024-09-02%20at%2010.04.34 AM.png)

- Create Workspace

![](./images/Screenshot%202024-09-02%20at%2010.07.56 AM.png)

- Connect with Github’s OAuth

![](./images/Screenshot%202024-09-02%20at%2010.10.46 AM.png)

![](./images/Screenshot%202024-09-02%20at%2010.11.21 AM.png)

- add client ID, and Auth

![](./images/Screenshot%202024-09-02%20at%2010.12.52 AM.png)

- github developer setting create new OAuth applications

![](./images/Screenshot%202024-09-02%20at%2010.13.55 AM.png)

- On GitHub, register a new OAuth Application. 
![](./images/Screenshot%202024-09-02%20at%2010.16.07 AM.png)

![](./images/Screenshot%202024-09-02%20at%2010.18.22 AM.png)

- Copy ID and Secret From Github and Paste

![](./images/Screenshot%202024-09-02%20at%2010.20.04 AM.png)

- set variable at terraform cloud

![](./images/Screenshot%202024-09-02%20at%2010.36.05 AM.png)

### Github Setup

- Create Token to authenticate the GitHub CLI with your GitHub account.
![](./images/Screenshot%202024-09-02%20at%2010.38.04 AM.png)

- github auth login

```
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ gh auth login 
? What account do you want to log into? \  [Use arrows to move, type to filter]

vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ gh auth login 
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Paste an authentication token
Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
The minimum required scopes are 'repo', 'read:org', 'workflow'.
? Paste your authentication token: ****************************************
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as aungkohtat
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ 
```

### HCP Setup

- Install vlt
```
sudo apt update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vlt -y
```

### Create Service Principal in HCP Portal Default Project

![](./images/Screenshot%202024-09-02%20at%2010.57.22 AM.png)

![](./images/Screenshot%202024-09-02%20at%2010.59.01 AM.png)

- After creating Service Principal key, create the followings

- `Client ID` - `xxxx`
- `Client Secret` - `xxxx`

### Export them as environment variables
```
export HCP_CLIENT_ID=xxxx
export HCP_CLIENT_SECRET=xxxx

env | grep HCP
```

![](./images/Screenshot%202024-09-02%20at%2011.02.06 AM.png)

- vault login

```
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ vlt login
Successfully logged in
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ 
```

- vlt config init

```
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ vlt config init
✔ Organization with name aungkohtet ID 0b6e56e3-0c35-46eb-8bb4-dedda4ca42ac selected
✔ Project with name default-project ID 6d889bf9-c1d6-47ed-9aed-d17fe05f4117 selected
You have no applications to configure. Try running `vlt apps create` to create a new application
Successfully wrote configuration to system
```

- Create Variable Set for HCP_CLIENT_ID and HCP_CLIENT_SECRET in Terraform Cloud

## Terraform Code to Create HCP Vault
- main.tf
- outputs.tf
- variables.tf
- version.tf

### Git Push to Git Repo

```
vagrant@cloud-native-box:~/aws-access-management-vault-terraform-cloud$ ls -la
total 28
drwxr-xr-x 1 vagrant vagrant  320 Sep  2 04:06 .
drwxr-xr-x 1 vagrant vagrant 1792 Sep  2 04:03 ..
drwxr-xr-x 1 vagrant vagrant  384 Sep  2 02:55 .git
-rw-r--r-- 1 vagrant vagrant   17 Sep  2 04:06 .gitignore
-rw-r--r-- 1 vagrant vagrant 4159 Sep  2  2024 README.md
drwxr-xr-x 1 vagrant vagrant  512 Sep  2 04:02 images
-rw-r--r-- 1 vagrant vagrant  476 Sep  2 04:05 main.tf
-rw-r--r-- 1 vagrant vagrant  909 Sep  2 04:06 outputs.tf
-rw-r--r-- 1 vagrant vagrant  675 Sep  2 04:05 variables.tf
-rw-r--r-- 1 vagrant vagrant 1146 Sep  2 04:04 version.tf
```



## New Run in Terraform Cloud for first time

![](./images/Screenshot%202024-09-02%20at%2011.18.50 AM.png)


HCP_CLIENT_SECRET="4g2bY2SOofMgjry373Tk2AH8VCyWvdAB1lwSbdryG9QiFZMXSnF1my49CXX9BBpF"
HCP_CLIENT_ID="k5PnwdefKV0vzVtZXHmFEwtDAfi6b1pt"