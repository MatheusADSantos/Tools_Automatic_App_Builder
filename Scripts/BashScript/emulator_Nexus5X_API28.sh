#!/bin/bash
cd /Users/macbook-estagio/Library/Android/sdk/emulator_original -dns-server 8.8.8.8 $@
./emulator_original -avd Nexus_5X_API_28