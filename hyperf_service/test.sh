echo "code format"
ssh vagrant@192.168.10.10 "cd /home/vagrant/Code/content_service && ./vendor/squizlabs/php_codesniffer/bin/phpcs --standard=PSR2 --error-severity=1 --warning-severity=6 app/"
echo "code format finished!"

echo "static-debugging"
ssh vagrant@192.168.10.10 "cd /home/vagrant/Code/content_service && ./vendor/phpstan/phpstan/phpstan analyse -l 0 -c phpstan.neon app/"
echo "static-debugging finished!"

echo "unit-test"
ssh vagrant@192.168.10.10 "cd /home/vagrant/Code/content_service && ./vendor/bin/phpunit test/"
echo "unit-test finished!"
