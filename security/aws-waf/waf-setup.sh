#!/bin/bash
aws wafv2 create-web-acl --name "T2S-WAF" --scope "REGIONAL"     --default-action Allow     --rules '[{"Name": "SQLInjection", "Priority": 1, "Statement": {"SqliMatchStatement": {"FieldToMatch": {"AllQueryArguments": {}}}}, "Action": {"Block": {}}}]' --region us-east-1
