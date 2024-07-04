# User Manual

## Overview

This manual provides comprehensive instructions on how to operate the SOAR Integration for Endpoint Defense system, detailing the setup, operation, and maintenance of the integrated components.

## System Requirements

### Hardware Requirements

- **Windows 10 Machine**: Minimum 4GB RAM, 20GB free disk space.
- **Ubuntu Server**: Minimum 4GB RAM, 20GB free disk space.

### Software Requirements

- **Windows 10**: Sysmon, Wazuh Agent, Mimikatz (for testing).
- **Ubuntu Server**: Wazuh Manager, Java, Cassandra, Elasticsearch, TheHive, Shuffle.

### Network Requirements

- Stable internet connection for external API integrations (e.g., VirusTotal).
- Configured firewall with necessary ports open (e.g., 9200 for Elasticsearch, 9000 for TheHive).

## Setup Instructions

### Windows 10 Setup

1. **Install Sysmon**:
    - Download Sysmon from the Sysinternals website.
    - Run the following command to install Sysmon with a basic configuration:
      ```sh
      sysmon -accepteula -i sysmonconfig.xml
      ```
    - Example configuration for `sysmonconfig.xml`:
      ```xml
      <Sysmon>
        <EventFiltering>
          <RuleGroup name="Process Create" groupRelation="or">
            <ProcessCreate onmatch="include">
              <Image condition="is">C:\Windows\System32\mimikatz.exe</Image>
            </ProcessCreate>
          </RuleGroup>
        </EventFiltering>
      </Sysmon>
      ```

2. **Install Wazuh Agent**:
    - Download the Wazuh agent installer from the Wazuh website.
    - Run the installer and follow the prompts.
    - Open `ossec-agent/ossec.conf` with administrative privileges.
    - Configure the Log Analysis section to monitor Sysmon logs:
      ```xml
      <localfile>
        <log_format>sysmon</log_format>
        <location>c:\windows\sysmon\sysmon.log</location>
      </localfile>
      ```

3. **Install Mimikatz**:
    - Download Mimikatz from the official GitHub repository.
    - Extract and install Mimikatz to a known location for testing purposes.

### Wazuh Manager Setup

1. **Install Wazuh**:
    - Update the package list and install Wazuh Manager:
      ```sh
      sudo apt update
      curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
      echo "deb https://packages.wazuh.com/4.x/apt stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
      sudo apt update
      sudo apt install wazuh-manager
      ```
    - Start and enable the Wazuh Manager service:
      ```sh
      sudo systemctl start wazuh-manager
      sudo systemctl enable wazuh-manager
      ```

### TheHive Setup

1. **Install Dependencies**:
    - Install Java:
      ```sh
      sudo apt install openjdk-11-jdk -y
      ```
    - Install Cassandra:
      ```sh
      echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
      curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
      sudo apt update
      sudo apt install cassandra
      ```
    - Start and enable the Cassandra service:
      ```sh
      sudo systemctl start cassandra
      sudo systemctl enable cassandra
      ```
    - Configure `cassandra.yaml`:
      ```yaml
      cluster_name: "FIR"
      listen_address: "<public_ip>"
      rpc_address: "<public_ip>"
      seeds: "<public_ip>:7000"
      ```

2. **Install Elasticsearch**:
    - Download and install Elasticsearch:
      ```sh
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-amd64.deb
      sudo dpkg -i elasticsearch-7.10.2-amd64.deb
      ```
    - Configure `elasticsearch.yml`:
      ```yaml
      cluster.name: "FIR"
      node.name: "node-1"
      network.host: "<public_ip>"
      http.port: 9200
      cluster.initial_master_nodes: ["node-1"]
      ```
    - Start and enable the Elasticsearch service:
      ```sh
      sudo systemctl start elasticsearch
      sudo systemctl enable elasticsearch
      ```

3. **Install TheHive**:
    - Add TheHive repository and install:
      ```sh
      echo "deb https://dl.bintray.com/thehive-project/debian stable main" | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
      sudo apt update
      sudo apt install thehive
      ```
    - Configure `application.conf`:
      ```hocon
      play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
      play.modules.enabled += org.thp.thehive.connector.misp.MispModule
      play.modules.enabled += org.thp.thehive.connector.thehive.TheHiveModule

      cluster.name = "FIR"
      cluster.node.name = "<public_ip>"

      application.baseUrl = "http://<public_ip>:9000"
      search.host = ["<public_ip>"]
      ```

### Shuffle Setup

1. **Sign Up and Configure**:
    - Sign up on Shuffle's website.
    - Add elements for automation, such as VirusTotal API, Wazuh Manager, and TheHive.

### SOC Analyst Setup

1. **Email Configuration**:
    - Use a temporary email service like Square X for receiving alerts.
    - Configure your email client to monitor and analyze alerts.

## Operating Instructions

### Starting the System

1. **Windows 10**:
    - Ensure Sysmon and Wazuh Agent are running.
    - Monitor Sysmon logs for suspicious activity.

2. **Ubuntu Server**:
    - Start Wazuh Manager, Cassandra, Elasticsearch, and TheHive services.
    - Use the following commands to start each service:
      ```sh
      sudo systemctl start wazuh-manager
      sudo systemctl start cassandra
      sudo systemctl start elasticsearch
      sudo systemctl start thehive
      ```

3. **Shuffle**:
    - Log into your Shuffle account.
    - Verify that all configured workflows are active.

### Monitoring and Alerts

1. **Wazuh Dashboard**:
    - Access the Wazuh dashboard at `http://<wazuh_manager_ip>:55000`.
    - Monitor real-time alerts and logs.

2. **TheHive Dashboard**:
    - Access TheHive dashboard at `http://<public_ip>:9000`.
    - Review and manage cases generated from alerts.

3. **Email Notifications**:
    - Monitor your temporary email for alerts from Shuffle.
    - Analyze and respond to alerts as needed.

### Responding to Incidents

1. **Investigating Alerts**:
    - Use the Wazuh dashboard to drill down into alert details.
    - Use TheHive to create and manage incident response cases.

2. **Taking Action**:
    - Follow predefined incident response procedures.
    - Use Shuffle workflows to automate responses, such as blocking IPs or enriching data.

### Maintenance

1. **Regular Updates**:
    - Regularly update all components (Wazuh, TheHive, Shuffle, and dependencies) to the latest versions.
    - Use the package manager to update:
      ```sh
      sudo apt update
      sudo apt upgrade
      ```

2. **Backups**:
    - Regularly back up configuration files and important data.
    - Use tools like `rsync` or cloud storage for backups.

3. **Monitoring and Logging**:
    - Ensure continuous monitoring of system logs for any errors or issues.
    - Use log management tools to aggregate and analyze logs.

## Troubleshooting

### Common Issues

1. **Wazuh Manager Not Starting**:
    - Check the Wazuh logs at `/var/ossec/logs/ossec.log`.
    - Verify network connectivity and configuration files.

2. **TheHive Not Connecting to Elasticsearch**:
    - Check the Elasticsearch logs at `/var/log/elasticsearch/elasticsearch.log`.
    - Ensure that `network.host` and other configurations are correctly set.

3. **Shuffle Workflow Failures**:
    - Check the Shuffle logs for errors.
    - Verify API keys and integration settings.

### Support

For additional support, refer to the official documentation for each component:
- [Wazuh Documentation](https://documentation.wazuh.com/)
- [TheHive Documentation](https://docs.thehive-project.org/)
- [Shuffle Documentation](https://shuffler.io/docs)



