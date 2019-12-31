# DevOps
Ejercicio DevOps sobre un free tier de AWS 

En el presente ejercicio se estara haciendo mendiante un script el despligue de una instancia free tier en AWS con Terraform donde a su vez se instalara Ansible y que este ultimo hara la instalacion y despligue de Docker y dos contenedores que estaran conectado entre si para obtener un resultado esperado como lo es una llamada a un helloworld, estos dos contenedores estan conformado por un contenedor de Kong api gateway y otro contenedor con que retorna un helloword, el fin de este ejercicio es registrar un servicio en kong que retorne el helloworld del segundo contenedor, sin mas que decir los paso para ejecutar el ejercicio acontinuacion:

Pasos para desplegar ejercicio devops

1. Descarga o clona este repositorio de en tu ruta de preferencia.

2. Crear cuenta para la consola de administracion AWS en el siguiente link:

    https://portal.aws.amazon.com/billing/signup#/start

3. Creacion de un grupo usuario en Identity and Access Management (IAM):
   
   Debes de crear un grupo en el IAM con los permisos necesarios para la creacion de instancias y volumen el cual utilizaremos para asociar el usuario en el siguiente paso.

   Url para la creacion del grupo: https://console.aws.amazon.com/iam/home?region=us-east-1#/groups

   Una vez definido el nombre del grupo solo debes asociarle la siguiente politica: AdministratorAccess

   Nombre sugerido: admin

4. Creacion de usuario y asignacion del grupo con los permisos necesarios para hacer el despligue del ejercicio con Terraform en el Identity and Access Management (IAM):

   Deberas de tomar nota del ID de clave de acceso y Clave de acceso secreta los cuales utilizaremos posteriormente para configurar nuestro archivo main.tf de Terraform.

   Url para la creacion del usuario: https://console.aws.amazon.com/iam/home?region=us-east-1#/users

   Nombre sugerido: devops

5. Creacion del Key Pair 

    En el siguiente paso debemos crear nuestro Key Pairs en el panel de EC2 con el fin de obtener la llave  privada el cual necesitaremos para que terraform pueda conectarse por SSH la instacia creada y pueda asi  ejecutar con exito los provisioners configurados en nuestro archivo main.tf de Terraform.

    Url para la creacion del Key Pairs:  https://console.aws.amazon.com/ec2/home?region=us-east-1#KeyPairs:sort=keyName

    En este puntos debes de crear una key pair asignarle un nombre y guardarlo en formato .pem

    Nombre sugerido: devops

6. Configuracion de nuestro archivo main.tf

    Ya en el presente punto debemos proceder a configurar nuestro archivo main.tf con los datos obtenidos y archivo del punto 4 y 5.

    Debes de configurar en primera instancia el access_key y secret_key que se encuentra ubicado en la linea 5 y 6 bloque del provider AWS en el archivo main.tf con los datos correspondientes del punto 4.

    Luego debes debes de registrar el nombre del key pair obtenido en el punto 5 en la linea 30 en bloque de la instancia que estamos creando en el archivo main.tf

    Posteriormente debemos registrar la ruta de nuestra llave privida, nuestro archivo .pm creado en el punto 5, en el bloque de connection que esta dentro del bloque de nuestra instancia, especificamente en la linea 45 del archivo main.tf

7. Ejecucion del script devops.sh para el despligue del ejercicio.

    Antes de ejecutar el script y en cuanto a este caso copie el archivo devops.pem en la carpeta raiz del ejercicio.
    
    Luego abra command line en la carpeta del ejercicio y ejecute bash devops.sh

Espere unos minutos que ejecute el despligue y verifique en la consola el resultado de la llamada de kong a  la api de helloworld.

Debera ver un mensaje similar al siguiente: 

 changed: [localhost] => {"changed": true, "cmd": "curl -i -X GET  --url http://localhost:8000/  --header 'Host: test.helloworld'\n", "delta": "0:00:00.534358", "end": "2019-12-30 13:12:25.236281", "rc": 0, "start": "2019-12-30 13:12:24.701923", "stderr": "  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100    24    0    24    0     0     45      0 --:--:-- --:--:-- --:--:--    45", "stderr_lines": ["  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current", "                                 Dload  Upload   Total   Spent    Left  Speed", "", "  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0", "100    24    0    24    0     0     45      0 --:--:-- --:--:-- --:--:--    45"], "stdout": "HTTP/1.1 200 \r\nContent-Type: application/json;charset=UTF-8\r\nTransfer-Encoding: chunked\r\nConnection: keep-alive\r\nDate: Mon, 30 Dec 2019 13:12:25 GMT\r\nX-Kong-Upstream-Latency: 485\r\nX-Kong-Proxy-Latency: 19\r\nVia: kong/1.4.2\r\n\r\n{\"message\":\"HelloWorld\"}", "stdout_lines": ["HTTP/1.1 200 ", "Content-Type: application/json;charset=UTF-8", "Transfer-Encoding: chunked", "Connection: keep-alive", "Date: Mon, 30 Dec 2019 13:12:25 GMT", "X-Kong-Upstream-Latency: 485", "X-Kong-Proxy-Latency: 19", "Via: kong/1.4.2", "", "{\"message\":\"HelloWorld\"}"]}

 Si ve correctamente al final del consola el  {\"message\":\"HelloWorld\"}, esta funcionando correctamente.

 Fin


 Adicional:

 Si desea ejecutar el script en un entorno windows 10 desde command line siga las siguientes guias:

 https://www.laptopmag.com/articles/use-bash-shell-windows-10


 # Resolver los siguientes challenge

    - docker container run -it --rm bennu/jobs:sh       (RESUELTO)

    En este contenedor existia un problema donde ejecutaba el bucle while para el file message en un subbash

    En la consola podra verificar con el State ExitCode (0) del contenedor bennu-jobs-sh en el TASK Print information about container BENNU SH el cual indica que el contenedor se ha creado, ejecutado y finalizado correctamente.

    - docker container run -it --rm bennu/jobs:missing      (RESUELTO)

    En este ultimo contenedor no existia el siguiente directorio /usr/local/bin/missing

    En la consola podra verificar con el State ExitCode (0) del contenedor bennu-jobs-sh en el TASK Print information about container BENNU missing el cual indica que el contenedor se ha creado, ejecutado y finalizado correctamente.

 
