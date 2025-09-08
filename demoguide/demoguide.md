[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
### # Deploy a Network-hardened web app with private PaaS datastore

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Below demo steps should be used **as a guideline** for doing your own demos. Please consider contributing to add additional demo steps.
</div>

[comment]: <> (this is the section for the Tip: item; consider adding a Tip, or remove the section between <div> and </div> if there is no tip)

***
### 1. What Resources are getting deployed

This scenario is aligned with the AZ-500 and AZ-104 path and provides a demo solution for creating an Azure App Service web app in a tightly controlled network environment with strict inbound and outbound network policies

Resources deployed: 
# Azure Deployment Resources

Here’s your list, now classified by **Azure resource type**:

### 🔹 Application & Web

* **appspazinsider** → Azure App Service Plan
* **webappazinsider** → Azure Web App (App Service)
* **webappazinsider-privateendpoint** → Private Endpoint for Web App
* **webappazinsider-privateendpoint.nic.b221f0b3-865b-46dc-a438-887aed** → Network Interface for Web App Private Endpoint

### 🔹 Database

* **sqlazinsider** → Azure SQL Database / Server
* **sqlazinsider-privateendpoint** → Private Endpoint for SQL Database
* **sqlazinsider-privateendpoint.nic.c8aaf041-97f9-486f-b63c-fbf08319b7e8** → Network Interface for SQL Private Endpoint
* **privatelink.database.windows.net** → Private DNS Zone for SQL Database

### 🔹 Networking & Security

* **firewallazinsider** → Azure Firewall
* **firewallipazinsider** → Public IP for Firewall
* **frontdoorazinsider** → Azure Front Door
* **nsgazinsider** → Network Security Group (NSG)
* **routetableazinsider** → Route Table
* **vnet-azinsider** → Virtual Network (VNet)
* **privatelink.azurewebsites.net** → Private DNS Zone for Web Apps




<img src="https://raw.githubusercontent.com/daverendon/azd-microsoft-sentinel/refs/heads/main/demoguide/rg-hardened-webapp.png" alt="Hardened Webapp" style="width:70%;">
<br></br>
<br></br>



### 2. What can I demo from this scenario after deployment

<img src="https://raw.githubusercontent.com/daverendon/azd-microsoft-sentinel/refs/heads/main/demoguide/azd-hardened-webapp-diagram.png" alt="Hardened webapp diagram" style="width:70%;">
<br></br>
<br></br>

Once you deploy the environment, you should be able to:

Task 1: Validate the Microsoft Sentinel configuration
Task 2: Validate the connection of Azure Activity to Sentinel
Task 3: Validate the rule that uses the Azure Activity data connector.
Task 4: Review the playbook
Task 5: Manage custom alerts and configure the playbook as an automated response.
Task 6: Invoke an incident and review the associated actions.


[comment]: <> (this is the closing section of the demo steps. Please do not change anything here to keep the layout consistant with the other demoguides.)
<br></br>
***
<div style="background: lightgray; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** This is the end of the current demo guide instructions.
</div>