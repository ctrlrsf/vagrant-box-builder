#! /usr/bin/env bash

set -o errexit
set -o nounset

BASE_VIRTUALBOX_VM_NAME="box-builder"

usage() {
  cat <<-EOF
	Usage: $0 OUTPUT_FILENAME

	Creates a new Vagrant box from an existing Vagrant box
EOF
  exit 1
}

get_virtualbox_vm_name() {
  VBoxManage list vms | grep "${BASE_VIRTUALBOX_VM_NAME}" | awk '{print $1}' | tr -d \"
}

main() {
  local box_output_file="${1:-}"

  [[ -z ${box_output_file} ]] && usage

  [[ ! -f Vagrantfile ]] && (echo "Vagrantfile is missing" && exit 1)


  printf "Building new vagrant box: %s\n" "${box_output_file}"

  printf "Running: vagrant up\n"
  vagrant up

  local virtualbox_vm_name
  virtualbox_vm_name="$(get_virtualbox_vm_name)"
  printf "Running: vagrant package --base %s --output %s\n" "${virtualbox_vm_name}" "${box_output_file}"
  vagrant package --base "${virtualbox_vm_name}" --output "${box_output_file}"
}

main "${@:-}"
