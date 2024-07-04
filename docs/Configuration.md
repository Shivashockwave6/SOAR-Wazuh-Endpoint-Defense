# Configuration Guide

This guide provides detailed steps to configure each component of your SOAR (Security Orchestration, Automation, and Response) project, integrating Wazuh for effective endpoint defense.

## Windows 10 Configuration

### Sysmon Installation and Configuration

1. **Install Sysmon:**
   - Download Sysmon from the Microsoft Sysinternals website: [Sysinternals - Sysmon](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon).
   - Extract the Sysmon archive and open Command Prompt as Administrator.
   - Navigate to the Sysmon directory and install it with the following command:
     ```bash
     sysmon -accepteula -i sysmonconfig.xml
     ```
     Replace `sysmonconfig.xml` with your custom Sysmon configuration file.

2. **Configure Wazuh Agent:**
   - Navigate to `ossec-agent/ossec.conf` located in the Wazuh agent directory.
   - Open the file with administrative privileges and update the `<log_analysis>` section to monitor Sysmon logs:
     ```xml
     <log_format>xml</log_format>
     <location>Windows Event Log</location>
     <log_overlap>5%</log_overlap>
     <log_type>sysmon</log_type>
     ```
   - Save the configuration file and restart the Wazuh agent service:
     ```bash
     net stop wazuh-agent
     net start wazuh-agent
     ```

3. **Install Mimikatz:**
   - Download Mimikatz from the official repository: [Mimikatz GitHub](https://github.com/gentilkiwi/mimikatz/releases).
   - Extract the Mimikatz archive and run it as Administrator from Command Prompt:
     ```cmd
     mimikatz.exe privilege::debug sekurlsa::logonpasswords exit
     ```
   - Verify that Wazuh alerts capture Mimikatz activities in the Wazuh manager dashboard.

## Ubuntu Server Configuration

### Wazuh Manager Installation and Configuration

1. **Install Wazuh Manager:**
   - Add the Wazuh repository GPG key:
     ```bash
     curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
     ```
   - Add the Wazuh repository to sources list:
     ```bash
     echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
     ```
   - Update and install Wazuh manager:
     ```bash
     sudo apt-get update
     sudo apt-get install wazuh-manager
     ```

2. **Configure Elasticsearch and Kibana:**
   - Install Elasticsearch and Kibana according to Wazuh documentation.
   - Configure Elasticsearch in `/etc/elasticsearch/elasticsearch.yml`:
     ```yaml
     cluster.name: wazuh
     network.host: localhost
     http.port: 9200
     ```
   - Start and enable Elasticsearch:
     ```bash
     sudo systemctl enable elasticsearch
     sudo systemctl start elasticsearch
     ```

### TheHive Installation and Configuration

1. **Install Prerequisites:**
   - Install Java JDK, Cassandra, and Elasticsearch as required by TheHive:
     ```bash
     sudo apt-get install default-jdk cassandra elasticsearch
     ```

2. **Configure TheHive:**
   - Download and install TheHive from the official repository or package manager.
   - Update TheHive configuration in `/etc/thehive/application.conf`:
     ```properties
     application.baseUrl = "http://localhost:9000"
     ```
   - Set permissions for TheHive installation directory:
     ```bash
     sudo chown -R thehive:thehive /opt/thehive
     ```

### Shuffle Configuration

1. **Sign Up and Add Elements:**
   - Register for Shuffle and configure integrations like VirusTotal API for data enrichment.
   - Refer to Shuffle documentation for detailed setup instructions.

### SOC Analyst Setup

1. **Temporary Email Setup:**
   - Use a temporary email provider for receiving alerts and notifications.
   - Set up sandbox environments for analyzing suspicious domains, phishing links, and attachments.

## Integration and Automation

### Wazuh Integration with TheHive and Shuffle

1. **Configure Webhooks:**
   - Integrate Wazuh Manager with TheHive and Shuffle using webhooks for automated incident response.
   - Define rules in Wazuh (`/var/ossec/etc/ossec.conf`) to trigger alerts for specific events.

2. **Automate Response Workflows:**
   - Use Shuffle to automate responses based on Wazuh alerts, enriching data with VirusTotal API.
   - Implement workflows in TheHive for case management and incident response.

## Conclusion

You have successfully configured each component of your SOAR system integrated with Wazuh for effective endpoint defense. Test your configurations thoroughly to ensure seamless operation.

This document provides an overview of configuration steps. For detailed steps, refer to the Installation and Implementation guides in the repository.
