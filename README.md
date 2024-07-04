# SOAR-Wazuh-Endpoint-Defense
Automated incident response with Wazuh SIEM and SOAR integration
## Overview
This project implements a Security Orchestration, Automation, and Response (SOAR) solution using Wazuh for SIEM and EDR capabilities. It aims to automate incident response and enhance endpoint defense through integration with Wazuh, TheHive for case management, Shuffle for SOAR capabilities, and additional enrichment using VirusTotal API.

## Components
- **Windows 10**: Endpoint with Wazuh agent installed.
- **Wazuh Manager**: SIEM and EDR platform installed on Ubuntu server.
- **Shuffle**: SOAR platform for automation, integrated with Wazuh and TheHive.
- **TheHive**: Case management system for incident response.
- **SOC Analyst**: Receives alerts and notifications via email from Shuffle after automation.

## Configuration
### Windows 10
- Installed Sysmon for enhanced event logging.
- Configured Wazuh agent to analyze Sysmon logs.
- Implemented MIMIKATZ for detecting credential dumping.

### Wazuh Manager
- Installed Wazuh on Ubuntu using curl command.
- Configured Wazuh to receive and analyze endpoint logs.
- Integrated Wazuh with Shuffle and TheHive for automated incident response.

### TheHive
- Installed Java, Cassandra, and Elasticsearch as prerequisites.
- Configured TheHive for case management.
- Integrated with Cortex for data enrichment and response capabilities.

### Shuffle
- Signed up and configured automation workflows.
- Integrated with Wazuh for receiving alerts and triggering responses.
- Utilized VirusTotal API for additional threat intelligence.

## Implementation
### Incident Response Automation
- **MIMIKATZ Detection**: Automatically detects MIMIKATZ execution on Windows using Wazuh alerts, regex matching, and VirusTotal API for threat validation.
- **Blocking Suspicious Domains**: Blocks access to suspicious domains or IPs on the Ubuntu endpoint using Wazuh Active Response and IPTables.

### Additional Test Cases
- **Phishing Detection**: Automated analysis of phishing links or attachments received via email.
- **Malware Detection**: Identification and blocking of malware based on VirusTotal intelligence.
