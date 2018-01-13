server {
       listen 80;
       listen [::]:80;

       server_name hw01.kousthubh.com;

       root /home/koushw01/www/hw01;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}

