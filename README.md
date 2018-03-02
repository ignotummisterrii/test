
* Desarrollo, dependencia
	* ruby version 2.4.0
	* rails version 5.0.6
	* redis
	* git

* Desarrollo, crear base de datos y set de prueba 
	
	>rake db:drop db:create db:migrate	

	>rake test:create

* Desarrollo, servicios  
	
	>rails s 
	
	>redis-server
	
	>sidekiq -c 1

* Desarrollo, ejecucion de los test

	>bundle exec rspec -fd

* Produccion dependencias servidor
	* rvm -> ruby version 2.4.0 + gem bundler
	* git -> generar y agregar la llave al repositorio
	* monit -> habilitar el acceso local /etc/monit/monitrc linea 118
	* redis-server
	* nginx
	* habilitar el puerto 80

* Produccion con Capistrano

	- Importante cambiar la configuración de los roles y ssh_option en 'config/deploy/production', ya que subi mi configuración.

> cap production deploy
> 
> cap production puma:start			


* Ejemplo
	* Este fue montado en una maquina virtual de amazon.

	Url
	> http://18.217.8.156/

	Muestra los vehiculos y con su ultimo registro.
    > http://18.217.8.156/show

	Para poder relizar un registro para un vehiculo, es necesario hacer un POST a :
    
    > http://18.217.8.156/api/v1/gps
  
    con formato
   
```js
	{
      		"latitude": 20.23,
      		"longitude": -0.56,
      		"sent_at": "2016-06-02 20:45:00",
      		"vehicle_identifier": "HA-3452"
	}
```
	
