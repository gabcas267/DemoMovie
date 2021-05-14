# DemoMovie

En el proyecto se ha utilizado el patron de diseño VIPER el cual tiene las clases:
· Vista es el View Controller donde se va a manejar toda la UI.
· Interactor, donde se realizan las consultas para consumo de servicio. 
· Presenter, donde se realiza la lógica de negocio.
· Entity, las entidades.
· Router, donde se maneja el navigation controller.
En la carpeta General se tiene:
· Un protocolo CommonRouterProtocol.
· Extensiones de las clases UIImageView y UINavigationController
· Una clase Manager para los servicios
· Enums y constantes

Principio de responsabilidad única:
Consiste en que las clases tengan una sola responsabilidad o que se enfoquen en algo en especifico y su propósito es que cuando se tenga que realizar algun cambio solo se efectue en la clase responsable. 
