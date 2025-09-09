# Deploy a Network-hardened web app with private PaaS datastore

## Overview

This repo contains a demo to help you deploy an Azure App Service web app in a tightly controlled network environment with strict inbound and outbound network policies

👉 https://blog.azinsider.net/deploying-network-hardened-web-apps-on-azure-with-azd-bicep-ac57591ad807?source=friends_link&sk=6d9ce4d1b16905898653a9338e546214


![Solution Architecture Diagram](https://raw.githubusercontent.com/daverendon/azd-hardened-webapp/refs/heads/main/demoguide/azd-hardened-webapp-diagram.png)


This scenario can be deployed to Azure using the [Azure Developer CLI - AZD](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview?WT.mc_id=AZ-MVP-5000671). 

💪 This template scenario is part of the larger **[Microsoft Trainer Demo Deploy Catalog](https://aka.ms/trainer-demo-deploy/?WT.mc_id=AZ-MVP-5000671)**.


## ⬇️ Installation
- [Azure Developer CLI - AZD](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd?WT.mc_id=AZ-MVP-5000671)
    - When installing AZD, the above the following tools will be installed on your machine as well, if not already installed:
        - [GitHub CLI](https://cli.github.com?WT.mc_id=AZ-MVP-5000671)
        - [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install?WT.mc_id=AZ-MVP-5000671)
    - You need Owner or Contributor access permissions to an Azure Subscription to  deploy the scenario.

## 🚀 Deploying the scenario in 3 easy steps:

1. From within a new folder on your machine, run `azd init` to initialize the deployment.
```
azd init -t daverendon/azd-hardened-webapp
```
2. Next, run `azd up` to trigger an actual deployment.
```
azd up
```
3. If you want to delete the scenario from your Azure subscription, use `azd down`
```
azd down --purge --force
```

⏩ Note: running `azd down` deletes the RG and Resources, but will keep the artifacts on your local machine. Re-run the azd up command again if any issues arise.

