#!/bin/bash
echo "Enter your github username (not email):"
read -r gitusername
php artisan down
git checkout develop
git reset --hard #carefully this command will destroy all changes of tracked files on server side code
git pull https://"$gitusername"@github.com/"$gitusername"/vienthonghoanganh.git develop:develop
chown nginx:nginx -R $(ls | awk '{if($1 != "node_modules"){ print $1 }}')
chmod 777 -R ./storage
php artisan cache:clear
php artisan view:clear
php artisan config:clear
php artisan route:clear
php artisan clear-compiled
gulp --production
composer dump-autoload
php artisan optimize --force
php artisan clear-all-cache
php artisan up