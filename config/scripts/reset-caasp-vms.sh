#!/bin/bash

###############################################################################
#  Global Vars
###############################################################################

### Colors ###
RED='\e[0;31m'
LTRED='\e[1;31m'
BLUE='\e[0;34m'
LTBLUE='\e[1;34m'
GREEN='\e[0;32m'
LTGREEN='\e[1;32m'
ORANGE='\e[0;33m'
YELLOW='\e[1;33m'
CYAN='\e[0;36m'
LTCYAN='\e[1;36m'
PURPLE='\e[0;35m'
LTPURPLE='\e[1;35m'
GRAY='\e[1;30m'
LTGRAY='\e[0;37m'
WHITE='\e[1;37m'
NC='\e[0m'
##############

COURSE_ID=CAAS201
IMAGE_SRC_DIR=/home/images/${COURSE_ID}
PRE_IMAGE_SRC_DIR=/home/images
VM_BASE_DIR=/home/VMs/${COURSE_ID}
PRE_VM_BASE_DIR=/home/VMs/
CLOUDINIT_TEMPLATE_DISK=${VM_BASE_DIR}/${COURSE_ID}-shared_disks/usb-disk-template.qcow2
IMAGE_FILE="SLES15-SP1-JeOS.x86_64-15.1-kvm-and-xen-GM.qcow2"

if [ -e /proc/net/vlan/vlan-caasp ]
then
  APPEND="-multi_lm"
else
  APPEND=""
fi

INSTALL_VM_LIST="master01 master02 master03 worker10 worker11 worker12 worker13 worker14"
#IMAGE_VM_LIST="${COURSE_ID}-master01 ${COURSE_ID}-master02 ${COURSE_ID}-master03 ${COURSE_ID}-worker10 ${COURSE_ID}-worker11 ${COURSE_ID}-worker12 ${COURSE_ID}-worker13 ${COURSE_ID}-worker14"
#CLOUDINIT_VM_LIST="worker13"
###############################################################################
#  Functions
###############################################################################

reset_install_vms() {
  cd ${VM_BASE_DIR}

  for VM in ${INSTALL_VM_LIST}
  do
    echo -e "${LTBLUE}*************************  VM: ${ORANGE}${VM}  ${LTBLUE}****************************${NC}"
    echo
# Stop VM
    echo -e "${GREEN}COMMAND: ${GRAY}virsh destroy ${COURSE_ID}-${VM}${NC}"
    virsh destroy ${COURSE_ID}-${VM}
# remove VM
    echo -e "${GREEN}COMMAND: ${GRAY}virsh undefine ${COURSE_ID}-${VM}${NC}"
    virsh undefine ${COURSE_ID}-${VM}
# redefine VM
    echo -e "${GREEN}COMMAND: ${GRAY}virsh define ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}${APPEND}.xml${NC}"
    virsh define ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}${APPEND}.xml

    sudo chmod 777 ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}.qcow2
    ~/course_files/${COURSE_ID}/config/scripts/reset-vm-disk-image.sh ${COURSE_ID}-${VM}


    case ${VM} in
      admin)
        if [ -e ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2 ]
        then
          echo "(skipping admin usb-disk.qcow2)"
          echo
        fi
      ;;
      *)
        if [ -e ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2 ]
        then
          echo -e "${GREEN}COMMAND: ${GRAY}sudo rm -f ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2${NC}"
          sudo rm -f ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2
          echo -e "${GREEN}COMMAND: ${GRAY}cp ${CLOUDINIT_TEMPLATE_DISK} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2${NC}"
          cp ${CLOUDINIT_TEMPLATE_DISK} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2
        fi
        echo
      ;;
    esac
  done
}

reset_image_vms() {
  cd ${VM_BASE_DIR}

  for VM in ${CLOUDINIT_VM_LIST}
  do
    echo -e "${LTBLUE}*************************  VM: ${ORANGE}${VM}  ${LTBLUE}****************************${NC}"
    echo
    echo -e "${GREEN}COMMAND: ${GRAY}virsh destroy ${COURSE_ID}-${VM}${NC}"
    virsh destroy ${COURSE_ID}-${VM}
    echo -e "${GREEN}COMMAND: ${GRAY}virsh undefine ${COURSE_ID}-${VM}${NC}"
    virsh undefine ${COURSE_ID}-${VM}
    echo -e "${GREEN}COMMAND: ${GRAY}virsh define ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}${APPEND}.xml${NC}"
#    virsh define ${PRE_VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}${APPEND}.xml
    virsh define ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}.xml
    echo
    echo -e "${LTBLUE}======================================================================${NC}"
    echo -e "${LTBLUE}Reseting the virtual disk: ${ORANGE}./${COURSE_ID}/${COURSE_ID}-${VM}.qcow2${NC}"
    echo -e "${LTBLUE}======================================================================${NC}"
    echo

    echo -e "${GREEN}COMMAND: ${GRAY}cd ./${COURSE_ID}-${VM}${NC}"
    echo -e "${GREEN}COMMAND: ${GRAY}sudo cp ${IMAGE_SRC_DIR}/${IMAGE_FILE} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}.qcow2${NC}"
    sudo cp ${IMAGE_SRC_DIR}/${IMAGE_FILE} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/${COURSE_ID}-${VM}.qcow2
    echo

    if [ -e ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2 ]
    then
      echo -e "${GREEN}COMMAND: ${GRAY}sudo rm -f ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2${NC}"
      sudo rm -f ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2
      echo -e "${GREEN}COMMAND: ${GRAY}cp ${CLOUDINIT_TEMPLATE_DISK} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2${NC}"
      cp ${CLOUDINIT_TEMPLATE_DISK} ${VM_BASE_DIR}/${COURSE_ID}-${VM}/usb-disk.qcow2
    fi
    echo
    echo -e "${LTBLUE}=============================  Finished  =============================${NC}"
    echo
  done
}



change_to_image() {
for VM in ${IMAGE_VM_LIST}
do
  
  echo
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo -e "${LTBLUE}#            Setting ${COURSE_ID} VMs${NC} to Preconfigured images"
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo
  
  
  echo
  echo -e "${LTBLUE}-Powering off VM (${ORANGE}${VM}${LTBLUE}) ...${NC}"
# Stop VM
  echo -e "${GREEN}COMMAND: ${GRAY}virsh destroy ${COURSE_ID}-${VM}${NC}"
  virsh destroy ${VM}
# Remove VM
  echo -e "${GREEN}COMMAND: ${GRAY}virsh undefine ${COURSE_ID}-${VM}${NC}"
  virsh undefine ${VM}
# Redefine VM
  echo -e "${GREEN}COMMAND: ${GRAY}virsh define ${PRE_VM_BASE_DIR}/${VM}/${VM}-with_usb.xml${NC}"
  virsh define ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/${VM}-with_usb.xml 
  echo
  sudo chmod 777 ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/${VM}.qcow2
  echo -e "${LTBLUE}-Copying qcow2 image file ...${NC}"
  echo -e "${GREEN}COMMAND: ${GRAY}sudo cp ${PRE_IMAGE_SRC_DIR}/${IMAGE_FILE} ${PRE_VM_BASE_DIR}/${COURSE_ID}-${VM}/${VM}.qcow2${NC}"
  sudo cp ${PRE_IMAGE_SRC_DIR}/${COURSE_ID}/${IMAGE_FILE} ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/${VM}.qcow2
  sudo chown .users ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/${VM}.qcow2
  sudo chmod g+rw ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/${VM}.qcow2
  echo
  done
}

reset_cloudinit_config() {
	for VM in ${IMAGE_VM_LIST}
  do	
  
  
  echo
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo -e "${LTBLUE}#      Setting cloudinit for ${COURSE_ID} VMs${NC} to Preconfigured images"
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo
  ls ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2
  sudo chmod 777 ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2
  echo -e "${LTBLUE}-Resetting cloud-init config ...${NC}"
  echo -e "${GREEN}COMMAND: ${GRAY}cp ${PRE_VM_BASE_DIR}/${COURSE_ID}/${COURSE_ID}-shared_disks/usb-disk-template.qcow2 ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2${NC}"
  sudo cp -v ${PRE_VM_BASE_DIR}/${COURSE_ID}/${COURSE_ID}-shared_disks/usb-disk-template.qcow2 ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2
  sudo chown .users ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2
  sudo chmod g+rw ${PRE_VM_BASE_DIR}/${COURSE_ID}/${VM}/usb-disk.qcow2
  done
}

main() {

  echo
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo -e "${LTBLUE}#                   Resetting ${COURSE_ID} VMs${NC}"
  echo -e "${LTBLUE}###############################################################################${NC}"
  echo

  if ! [ -z "${INSTALL_VM_LIST}" ]
  then
    reset_install_vms
  fi

  if ! [ -z "${CLOUDINIT_VM_LIST}" ]
  then
    reset_image_vms
  fi

  if ! [ -z "${IMAGE_VM_LIST}" ]
  then
    change_to_image
    reset_cloudinit_config
  fi
  
}

###############################################################################
#  Main Code Body
###############################################################################

main
