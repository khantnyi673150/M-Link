# ⚠️ CRITICAL: Keystore Backup Instructions

## Files You Must Protect

These files are **IRREPLACEABLE** and required for publishing updates to Google Play Store:

```
android/app/release.keystore    (4.2 KB)
android/key.properties           (92 B)
```

**If you lose these files, you CANNOT update your app on Play Store.**

---

## Backup Strategy

### 1. **Offline Encrypted Backup** (REQUIRED)
```bash
# Create an encrypted backup
tar czf - android/app/release.keystore android/key.properties | \
  gpg --symmetric --cipher-algo AES256 --output mlink-keystore-backup.tar.gz.gpg
```

Store this file on:
- ✅ External USB drive (encrypted)
- ✅ Personal cloud storage (encrypted password manager like Bitwarden)
- ✅ Hardware security key
- ❌ GitHub/GitLab (even private repos)
- ❌ Cloud drives without encryption (Google Drive, Dropbox unencrypted)

### 2. **What's Inside key.properties**
```properties
storeFile=app/release.keystore
storePassword=<your_store_password>   # Use your real secret value
keyPassword=<your_key_password>       # Use your real secret value
keyAlias=release                 # Alias name
```

**NEVER commit this to Git.** The `.gitignore` already protects this.

### 3. **Restore from Backup**
```bash
# Decrypt and restore
gpg --decrypt --output mlink-keystore-backup.tar.gz mlink-keystore-backup.tar.gz.gpg
tar xzf mlink-keystore-backup.tar.gz
```

---

## Lost Keystore Recovery

If you lose the keystore:
1. **You cannot update the existing app** on Play Store with the same package name
2. **You must**:
   - Change package name to something new (e.g., `com.khantnyi.mlink2`)
   - Create a new app listing
   - Migrate users manually (hard!)

**This is why backup is critical.**

---

## Keystore Information

**Created**: April 17, 2026
**Validity**: 10,950 days (30 years)
**Algorithm**: RSA-4096
**Package**: com.khantnyi.mlink
**Alias**: release

---

## Checklist

- [ ] Back up `release.keystore` to encrypted external storage
- [ ] Back up `key.properties` (or save passwords in secure password manager)
- [ ] Verify `.gitignore` has `key.properties` (✓ Already done)
- [ ] Verify `.gitignore` has `**/*.keystore` (✓ Already done)
- [ ] Test restore process once (important!)
- [ ] Never commit keystore to version control

