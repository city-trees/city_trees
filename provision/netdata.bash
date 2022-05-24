#!/bin/bash

# Download netdata
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh

# Instal and connect to cloud
sh /tmp/netdata-kickstart.sh \
  --claim-token EkWRjMCi27GHJmUfAI6VvQhAhmUvrTXg7kPWLS95c_ja_Gzp1lFkdWPUwewR7v0qxTT7INRCdbhO3CZforB2rOCtOwOvm5faheJG6H5yHfl73MzFYwX7GkHqPNvaS3qTqbe07LY \
  --claim-url https://app.netdata.cloud