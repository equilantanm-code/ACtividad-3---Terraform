#!/bin/bash
# =============================================================================
# Script de provisioning: instala y configura MongoDB 7.x en Ubuntu 22.04
# =============================================================================
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "=== 1. Esperando que cloud-init y bloqueos de apt terminen ==="
if command -v cloud-init &> /dev/null; then
    sudo cloud-init status --wait || true
fi
sudo fuser -vki /var/lib/dpkg/lock-frontend /var/lib/apt/lists/lock /var/lib/dpkg/lock || true
sudo dpkg --configure -a || true

echo "=== 2. Actualizar paquetes base ==="
apt-get update -y
apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt-get install -y curl gnupg ufw

echo "=== 3. Agregar repositorio oficial de MongoDB 7.x ==="
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-7.0.list

echo "=== 4. Instalar MongoDB ==="
apt-get update -y
apt-get install -y mongodb-org

echo "=== 5. Configurar MongoDB ==="
# Escuchar en todas las interfaces de la VPC (no solo localhost)
# En producción Terraform restringe el acceso por Security Group (puerto 27017)
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# Habilitar autenticación
cat >> /etc/mongod.conf <<'EOF'

security:
  authorization: enabled
EOF

echo "=== 6. Habilitar y arrancar mongod como servicio ==="
systemctl daemon-reload
systemctl enable mongod
systemctl start mongod

echo "=== 7. Esperar a que MongoDB esté listo ==="
sleep 5
until mongosh --eval "db.adminCommand({ ping: 1 })" --quiet; do
    echo "Esperando MongoDB..."
    sleep 3
done

echo "=== 8. Crear usuario administrador de MongoDB ==="
# Credenciales por defecto — cambialas antes de producción real
mongosh admin --eval "
  db.createUser({
    user: 'admindb',
    pwd:  'Zxcvbnm.0',
    roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }, 'readWriteAnyDatabase']
  })
"

echo "=== 9. Configurar reglas de firewall (UFW) ==="
ufw allow OpenSSH
# Puerto 27017 NO se abre en UFW — lo controla el Security Group de AWS
echo "y" | ufw enable

echo "=== 10. Detener MongoDB para que la AMI arranque limpia ==="
# Se detiene para que al lanzar la instancia desde la AMI,
# systemd lo inicie fresco sin datos de build
systemctl stop mongod

echo "=== Provisioning MongoDB completado con éxito ==="
mongod --version
