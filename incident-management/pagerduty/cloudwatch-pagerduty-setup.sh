#!/bin/bash
aws sns create-topic --name PagerDutyAlerts
aws sns subscribe --topic-arn arn:aws:sns:us-east-1:123456789012:PagerDutyAlerts     --protocol https --notification-endpoint https://events.pagerduty.com/integration/YOUR-INTEGRATION-KEY/enqueue
