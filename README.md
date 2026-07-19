# Samsung wisdom LineageOS 23.2 Platform Patches

Platform patches used by the Samsung wisdom / SM-P205 LineageOS 23.2 bring-up.
The default script mode applies the current release-candidate platform patch set
used by the 2026-07-03 tester package.

Apply after `repo sync` and before building:

```bash
cd /path/to/lineageos23.2
git clone https://github.com/xuanyayi/android_patches_samsung_wisdom -b lineage-23.2 patches/samsung/wisdom
./patches/samsung/wisdom/apply-patches.sh "$PWD"
```

Full source setup:

```bash
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs
mkdir -p .repo/local_manifests
curl -L https://raw.githubusercontent.com/xuanyayi/android_manifest_samsung_wisdom/lineage-23.2/wisdom.xml \
  -o .repo/local_manifests/wisdom.xml
repo sync -c --force-sync --no-clone-bundle --no-tags -j"$(nproc --all)"
./patches/samsung/wisdom/apply-patches.sh "$PWD"
source build/envsetup.sh
lunch lineage_wisdom-bp4a-userdebug
mka bacon -j"$(nproc --all)"
```

The script is idempotent: it skips patches that are already applied and fails
if a patch conflicts with the current source tree.

Latest validated local tester package:

- `lineage-23.2-20260719-UNOFFICIAL-wisdom.zip`
- SHA-256:
  `abcb46c55c29e627d23d4862dbf852a84151102a535851a4923d070e56dd7390`
- Runtime proof: `mka bacon` passed, sideload/TWRP install returned success,
  `sys.boot_completed=1`, `ro.build.version.incremental=1784431468`,
  `vold.has_adoptable=1`, and `sm has-adoptable=true`. S Pen side-button wake
  is carried by the wisdom prebuilt kernel. The current patch queue keeps the
  earlier Widevine `CBS_init`, media, OMC/RILD, Bluetooth HCI metrics,
  SystemUI screen-recording, Wi-Fi rate-stat, and legacy gralloc/BLAST fixes.
  It also hides the unsupported S2MU004 learned maximum-capacity row through a
  Settings overlay while leaving design capacity visible.

To try the full LOS22.2-derived queue after manually resolving LOS23.2 drift,
run:

```bash
./patches/samsung/wisdom/apply-patches.sh "$PWD" all
```
