# Samsung wisdom LineageOS 23.2 Platform Patches

Platform patches used by the Samsung wisdom / SM-P205 LineageOS 23.2 bring-up.
The default script mode applies the current release-candidate platform patch set
used by the 2026-07-02 tester package.

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

- `lineage-23.2-20260702-UNOFFICIAL-wisdom.zip`
- SHA-256:
  `d3346dc9c6333582dcd8cb0758dce115919a3351aac386fec5c749bb6c75cab5`
- Runtime proof: TWRP install exit 0, incremental `1782983697`,
  `sys.boot_completed=1`; local video and Nitter web video playback work.

To try the full LOS22.2-derived queue after manually resolving LOS23.2 drift,
run:

```bash
./patches/samsung/wisdom/apply-patches.sh "$PWD" all
```
