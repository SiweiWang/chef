#!/bin/bash
sudo nmcli connection reload
sudo systemctl restart network.service
