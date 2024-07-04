# Test Cases and Scenarios

This document outlines various test cases and scenarios for validating the functionality and effectiveness of your SOAR (Security Orchestration, Automation, and Response) project integrated with Wazuh for endpoint defense.

## Test Case 1: MIMIKATZ Detection and Response

### Objective
Verify the detection and automated response capabilities for MIMIKATZ activities on Windows endpoints.

### Steps
1. **Simulate MIMIKATZ Execution:**
   - Execute MIMIKATZ on a test Windows 10 machine.
   - Ensure Wazuh agent detects the activity and triggers an alert.

2. **Alert Enrichment and Analysis:**
   - Verify that Shuffle enriches the Wazuh alert with VirusTotal data.
   - Confirm TheHive creates a case for the detected MIMIKATZ activity.

3. **Automated Response Validation:**
   - Check if Shuffle automated response actions (e.g., quarantine user, isolate endpoint) are executed based on predefined rules.

4. **SOC Analyst Confirmation:**
   - Evaluate the email notification received by SOC analysts.
   - Analyze the provided information and take necessary actions through TheHive interface.

## Test Case 2: IP Blocking and Firewall Rules

### Objective
Test the capability to block suspicious IP addresses on Ubuntu endpoints using Wazuh Active Response.

### Steps
1. **Retrieve Threat Intel Data:**
   - Fetch a list of known suspicious IP addresses from threat intelligence feeds using Wazuh API.

2. **Automated IP Blocking:**
   - Configure Wazuh manager to block selected IP addresses on Ubuntu endpoints.
   - Verify if the blocking action is successfully applied using Wazuh agent control commands.

3. **Manual Verification:**
   - Manually confirm the IP blocking status on the Ubuntu endpoint's firewall.
   - Ensure that Shuffle sends email notifications to SOC analysts for manual review and further action.

## Test Case 3: Phishing Domain Detection

### Objective
Validate the detection and response workflow for phishing domain alerts.

### Steps
1. **Phishing Domain Detection Setup:**
   - Configure Wazuh rules to detect URLs associated with known phishing domains.

2. **Alert Handling and Enrichment:**
   - Ensure Shuffle enriches the alert with additional threat intelligence data from VirusTotal.
   - Verify that TheHive creates a case for the detected phishing domain alert.

3. **Automated Response Validation:**
   - Test automated response actions configured in Shuffle (e.g., block URL, notify user).

4. **SOC Analyst Review:**
   - Review the email notification received by SOC analysts.
   - Validate SOC analyst's interaction with TheHive for case management and incident response.

## Conclusion

These test cases cover critical scenarios to validate the effectiveness and functionality of your SOAR project integrated with Wazuh for endpoint defense. Regularly update and expand your test cases to reflect evolving threats and operational requirements.

For detailed steps on installation, configuration, and implementation, refer to the respective guides in this repository.
