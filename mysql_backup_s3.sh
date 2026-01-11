#!/bin/bash
set -e

# ================= CONFIGURATION =================
MYSQL_CONTAINER="mysql"
DB_USER="root"
DB_PASSWORD="rootpass"
DB_NAME="testdb"

BACKUP_DIR="./mysql-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${DB_NAME}_${TIMESTAMP}.sql"
COMPRESSED_FILE="${BACKUP_FILE}.gz"

S3_BUCKET="s3://dkmd/mysql-backups"

# ================= PREPARATION =================
mkdir -p "$BACKUP_DIR"

echo "🔍 Checking MySQL database availability..."

if ! docker exec "$MYSQL_CONTAINER" \
  mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME;" >/dev/null 2>&1; then
  echo "❌ Database '$DB_NAME' does not exist. Backup aborted."
  exit 1
fi

# ================= BACKUP =================
echo "📦 Starting MySQL backup..."

docker exec "$MYSQL_CONTAINER" \
  mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
  > "$BACKUP_DIR/$BACKUP_FILE"

# ================= COMPRESSION =================
gzip "$BACKUP_DIR/$BACKUP_FILE"

echo "✅ Backup created: $BACKUP_DIR/$COMPRESSED_FILE"

# ================= S3 UPLOAD =================
echo "☁️ Uploading backup to Amazon S3..."

aws s3 cp "$BACKUP_DIR/$COMPRESSED_FILE" "$S3_BUCKET/"

echo "✅ Backup uploaded successfully to S3"
