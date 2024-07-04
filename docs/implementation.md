# Implementation Guide

This guide provides detailed steps to implement your SOAR (Security Orchestration, Automation, and Response) project integrated with Wazuh for endpoint defense.

## MIMIKATZ Alert Implementation

### Configuring Shuffle for Data Enrichment

1. **Configure Wazuh Alerts:**
   - Set up Wazuh rules (`/var/ossec/etc/ossec.conf`) to detect Mimikatz activities.
   - Example rule:
     ```xml
     <rule id="100002" level="6">
       <decoded_as>win</decoded_as>
       <field name="win.eventdata.Image">(?i)mimikatz.exe</field>
       <description>Mimikatz detected on Windows endpoint</description>
     </rule>
     ```

2. **Integrate VirusTotal API:**
   - Sign up for VirusTotal and obtain API key.
   - Configure Shuffle to enrich Wazuh alerts with VirusTotal data using regex for SHA-256 hashes.

3. **Webhook Integration with TheHive:**
   - Set up webhooks in Wazuh (`ossec.conf`) to send alerts to TheHive.
   - Example webhook configuration:
     ```xml
     <integration>
       <name>TheHive</name>
       <hook_url>http://thehive-server:9000</hook_url>
       <rule_id>100002</rule_id>
     </integration>
     ```

4. **Automate Response Workflow:**
   - Define response actions in Shuffle to automate incident response based on Wazuh alerts.
   - Use TheHive to manage and track incidents related to Mimikatz detections.

## Blocking Suspicious Access Implementation

### Blocking IP Addresses on Ubuntu Endpoint

1. **Retrieve Threat Intel Data:**
   - Fetch suspicious IP addresses from threat intelligence sources using Wazuh API.
   - Example API call:
     ```bash
     curl -u USER:PASSWORD -k -X GET https://wazuh-manager-ip:55000/security/agents
     ```

2. **Configure Wazuh Active Response:**
   - Update Wazuh manager (`ossec.conf`) to enable Active Response for firewall blocking.
   - Example configuration:
     ```xml
     <active_response>
       <command>firewall-drop</command>
       <timeout>no</timeout>
     </active_response>
     ```

3. **Manual IP Blocking:**
   - Manually block suspicious IP addresses on Ubuntu endpoint using Wazuh agent control commands.
   - Example command:
     ```bash
     ./agent-control -b 8.8.8.8 -f
     ```

4. **Email Notification Setup:**
   - Configure Shuffle to send email notifications to SOC analysts for manual confirmation and further action on blocked IPs.

## Additional Test Cases

### Real-time Detection and Mitigation Scenarios

1. **Phishing Domain Detection:**
   - Implement detection rules in Wazuh for phishing domains using domain reputation services.
   - Automate reporting and alerting through Shuffle to SOC analysts.

2. **Malware File Detection:**
   - Enhance Wazuh rules to detect malware files based on VirusTotal reports.
   - Automate file analysis and response actions using TheHive and Shuffle workflows.

## Conclusion

You have successfully implemented your SOAR project integrated with Wazuh for endpoint defense, covering MIMIKATZ alerting, IP blocking, and additional test cases for real-time detection and mitigation. Test your implementations thoroughly to ensure effective security operations.

For more detailed instructions and configurations, refer to the Installation and Configuration guides in this repository.
