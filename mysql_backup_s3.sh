#!/bin/bash

# ================= CONFIG =================
MYSQL_CONTAINER="mysql"
DB_USER="root"
DB_PASSWORD="rootpass"
DB_NAME="testdb"

BACKUP_DIR="./mysql-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${DB_NAME}_${TIMESTAMP}.sql"

S3_BUCKET="s3://my-mysql-backups-bucket"

# ================= PREP =================
mkdir -p "$BACKUP_DIR"

echo "Checking database availability..."

docker exec "$MYSQL_CONTAINER" \
  mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME;" >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "❌ Database '$DB_NAME' does not exist. Backup aborted."
  exit 1
fi

# ================= BACKUP =================
echo "Starting MySQL backup..."

docker exec "$MYSQL_CONTAINER" \
  mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
  > "$BACKUP_DIR/$BACKUP_FILE"

if [ $? -ne 0 ]; then
  echo "❌ MySQL backup failed"
  exit 1
fi

echo "✅ Backup created: $BACKUP_DIR/$BACKUP_FILE"

# ================= S3 UPLOAD =================
echo "Uploading backup to S3..."

aws s3 cp "$BACKUP_DIR/$BACKUP_FILE" "$S3_BUCKET/"

if [ $? -ne 0 ]; then
  echo "❌ S3 upload failed"
  exit 1
fi

echo "✅ Backup uploaded to S3 successfully"
