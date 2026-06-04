# Samsung wisdom LineageOS 20 Platform Patches

Platform patches used by the Samsung wisdom / SM-P205 LineageOS 20 bring-up.

Apply after `repo sync` and before building:

```bash
cd /path/to/lineageos20
git clone https://github.com/xuanyayi/android_patches_samsung_wisdom -b lineage-20 patches/samsung/wisdom
./patches/samsung/wisdom/apply-patches.sh "$PWD"
```

The script is idempotent: it skips patches that are already applied and fails
if a patch conflicts with the current source tree.
