# DevOps
Ejercicio DevOps sobre un free tier de AWS 

Pasos para desplegar ejercicio devops

1. Crear cuenta para la consola de administracion AWS en el siguiente link:

    https://portal.aws.amazon.com/billing/signup#/start

2. Creacion de un grupo y usuario en Identity and Access Management (IAM):
   
   Debes de crear un grupo en el IAM con los permisos necesarios para la creacion de instancias y volumen el cual utilizaremos para asociar el usuario en el siguiente paso.

   Url para la creacion del grupo: https://console.aws.amazon.com/iam/home?region=us-east-1#/groups

   Una vez definido el nombre del grupo solo debes asociarle la siguiente politica: AdministratorAccess

3. Creacion de usuario y asignacion del grupo con los permisos necesarios para hacer el despligue del ejercicio con Terraform.

   Nota debes de tomar nota del ID de clave de acceso y Clave de acceso secreta los cuales utilizaremos posteriormente para configurar nuestro archivo main.tf de Terraform.

   Url para la creacion del usuario: https://console.aws.amazon.com/iam/home?region=us-east-1#/users

4. En el siguiente paso debemos crear nuestro Key Pairs en el panel de EC2 con el fin de obtener la llave privada el cual necesitaremos para que terraform pueda conectarse por SSH la instacia creada y pueda asi ejecutar con exito los provisioners configurados en nuestro archivo main.tf de Terraform