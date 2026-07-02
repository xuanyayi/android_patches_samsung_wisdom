#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$PWD}"
PATCH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODE="${2:-release-current}"

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

case "${MODE}" in
  release-current|--release-current|bootable-first|--bootable-first)
    apply_patch bionic bionic.patch
    apply_patch device/samsung_slsi/sepolicy device_samsung_slsi_sepolicy.patch
    apply_patch external/tinyalsa external_tinyalsa.patch
    apply_patch external/wpa_supplicant_8 external_wpa_supplicant_8.patch
    apply_patch frameworks/av frameworks_av.patch
    apply_patch frameworks/base frameworks_base.patch
    apply_patch frameworks/ex frameworks_ex.patch
    apply_patch frameworks/native frameworks_native.patch
    apply_patch hardware/interfaces hardware_interfaces.patch
    apply_patch hardware/lineage/interfaces hardware_lineage_interfaces.patch
    apply_patch hardware/samsung hardware_samsung.patch
    apply_patch hardware/samsung_slsi-linaro/openmax hardware_samsung_slsi-linaro_openmax.patch
    apply_patch hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib hardware_samsung_slsi_scsc_wifibt_wpa_supplicant_lib.patch
    apply_patch packages/apps/Camera2 packages_apps_Camera2.patch
    apply_patch packages/apps/Settings packages_apps_Settings.patch
    apply_patch packages/modules/Connectivity packages_modules_Connectivity.patch
    apply_patch packages/modules/Wifi packages_modules_Wifi.patch
    apply_patch packages/modules/adb packages_modules_adb.patch
    apply_patch packages/services/Mtp packages_services_Mtp.patch
    apply_patch system/core system_core.patch
    apply_patch system/hwservicemanager system_hwservicemanager.patch
    apply_patch system/media system_media.patch
    apply_patch system/memory/libmeminfo system_memory_libmeminfo.patch
    apply_patch system/netd system_netd.patch
    apply_patch system/tools/mkbootimg system_tools_mkbootimg.patch
    ;;
  all|--all)
    apply_patch bionic bionic.patch
    apply_patch device/samsung_slsi/sepolicy device_samsung_slsi_sepolicy.patch
    apply_patch external/tinyalsa external_tinyalsa.patch
    apply_patch external/wpa_supplicant_8 external_wpa_supplicant_8.patch
    apply_patch frameworks/av frameworks_av.patch
    apply_patch frameworks/base frameworks_base.patch
    apply_patch frameworks/ex frameworks_ex.patch
    apply_patch frameworks/native frameworks_native.patch
    apply_patch hardware/interfaces hardware_interfaces.patch
    apply_patch hardware/lineage/interfaces hardware_lineage_interfaces.patch
    apply_patch hardware/samsung hardware_samsung.patch
    apply_patch hardware/samsung_slsi-linaro/openmax hardware_samsung_slsi-linaro_openmax.patch
    apply_patch hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib hardware_samsung_slsi_scsc_wifibt_wpa_supplicant_lib.patch
    apply_patch packages/apps/Aperture packages_apps_Aperture.patch
    apply_patch packages/apps/Camera2 packages_apps_Camera2.patch
    apply_patch packages/apps/Settings packages_apps_Settings.patch
    apply_patch packages/modules/Connectivity packages_modules_Connectivity.patch
    apply_patch packages/modules/DnsResolver packages_modules_DnsResolver.patch
    apply_patch packages/modules/Wifi packages_modules_Wifi.patch
    apply_patch packages/modules/adb packages_modules_adb.patch
    apply_patch packages/services/Mtp packages_services_Mtp.patch
    apply_patch system/core system_core.patch
    apply_patch system/hwservicemanager system_hwservicemanager.patch
    apply_patch system/media system_media.patch
    apply_patch system/memory/libmeminfo system_memory_libmeminfo.patch
    apply_patch system/netd system_netd.patch
    apply_patch system/tools/mkbootimg system_tools_mkbootimg.patch
    apply_patch vendor/lineage vendor_lineage.patch
    ;;
  *)
    echo "usage: $0 [root] [release-current|bootable-first|all]" >&2
    exit 2
    ;;
esac
