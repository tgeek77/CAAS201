#!/bin/bash

echo "Now installing CaaSP Images"
mirror-container-images-caasp.sh
echo "Now installing CAP Images"
mirror-container-images-cap.sh  
echo "Now installing Misc Images"
mirror-container-images.sh
