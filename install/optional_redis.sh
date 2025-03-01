echo "Redis is optional, but improves performance..."
sudo dnf install redis -y

echo "************IMPORTANT*********************"
echo "You must now manually edit /etc/redis/redis.conf to have the value 'supervised no' to 'supervised systemd'."
echo "Restart it afterwards with systemctl"
echo "*********************************"

sudo systemctl restart redis.service


