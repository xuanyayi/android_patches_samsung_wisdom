#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$PWD}"
PATCH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apply_patch() {
  local project="$1"
  local patch="$2"
  local project_dir="${ROOT}/${project}"
  local patch_file="${PATCH_DIR}/${patch}"

  if [ ! -d "${project_dir}/.git" ]; then
    echo "missing project: ${project}" >&2
    return 1
  fi

  if git -C "${project_dir}" apply --check "${patch_file}" >/dev/null 2>&1; then
    git -C "${project_dir}" apply "${patch_file}"
    echo "applied ${patch}"
  elif git -C "${project_dir}" apply --reverse --check "${patch_file}" >/dev/null 2>&1; then
    echo "already applied ${patch}"
  else
    echo "failed to apply ${patch}" >&2
    return 1
  fi
}

apply_patch frameworks/av frameworks_av.patch
apply_patch external/wpa_supplicant_8 external_wpa_supplicant_8.patch
apply_patch frameworks/base frameworks_base.patch
apply_patch frameworks/native frameworks_native.patch
apply_patch frameworks/opt/net/ims frameworks_opt_net_ims.patch
apply_patch frameworks/opt/telephony frameworks_opt_telephony.patch
apply_patch packages/apps/CarrierConfig packages_apps_CarrierConfig.patch
apply_patch hardware/interfaces hardware_interfaces.patch
apply_patch hardware/lineage/interfaces hardware_lineage_interfaces.patch
apply_patch hardware/samsung hardware_samsung.patch
apply_patch packages/apps/Jelly packages_apps_Jelly.patch
apply_patch packages/apps/LineageParts packages_apps_LineageParts.patch
apply_patch packages/apps/Settings packages_apps_Settings.patch
apply_patch packages/modules/Connectivity packages_modules_Connectivity.patch
apply_patch system/apex system_apex.patch
apply_patch system/bpf system_bpf.patch
apply_patch system/core system_core.patch
apply_patch system/memory/libmeminfo system_memory_libmeminfo.patch
apply_patch system/netd system_netd.patch
apply_patch vendor/apn vendor_apn.patch
apply_patch vendor/lineage vendor_lineage.patch
