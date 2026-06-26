# 🐉 Dragon Ball Flappy 

Un juego 2D de supervivencia y obstáculos desarrollado en **Godot Engine** utilizando **GDScript**. El objetivo es esquivar obstáculos generados procedimentalmente, acumular la mayor cantidad de puntos posible y recolectar monedas para desbloquear a diferentes personajes.

## 🎮 Mecánicas Principales

* El jugador controla a un personaje afectado por la gravedad que debe saltar para mantenerse en el aire y esquivar tuberías u obstáculos.
* Los obstáculos se generan automáticamente a alturas aleatorias fuera de la pantalla.
* Los obstáculos se mueven continuamente hacia la izquierda hacia el jugador.
* El suelo tiene un efecto de desplazamiento continuo para crear una ilusión de avance infinito.
* El juego termina si el jugador choca contra un obstáculo.
* El juego también termina si el jugador cae al suelo.

## 💰 Progresión y Tienda

* El jugador acumula tanto puntos como monedas cada vez que logra atravesar la zona de puntuación de un obstáculo.
* El progreso del jugador, incluyendo la máxima puntuación, las monedas acumuladas y las apariencias desbloqueadas, se guarda localmente en un archivo JSON (`user://save.json`).
* Al perder, el juego otorga diferentes medallas visuales dependiendo del rendimiento: una normal, una al superar los 15 puntos y otra al superar los 20 puntos.
* El menú incluye una tienda integrada donde los jugadores pueden gastar sus monedas para desbloquear nuevas apariencias (*skins*).
* Los personajes disponibles incluyen a Goku (desbloqueado por defecto), Vegeta (50 monedas), Gohan (100 monedas) y Black (200 monedas).

## 🛠️ Estructura del Proyecto y Scripts

* **`Player.gd`**: Maneja las físicas del jugador, aplicando gravedad, limitando la velocidad máxima de caída y reproduciendo animaciones y efectos de sonido al saltar o chocar.
* **`Spawner.gd`**: Se encarga de instanciar los obstáculos dinámicamente utilizando un Temporizador (`Timer`) y calcula la altura aleatoria basándose en el tamaño de la ventana de visualización.
* **`GameUI.gd`**: Gestiona toda la interfaz de usuario, conectando los botones con los menús de inicio, fin de juego y la tienda de personajes.
* **`Ground.gd`**: Controla las áreas de colisión del suelo y reubica las partes del escenario para lograr un ciclo infinito.
* **`Main.gd` (Script principal)**: Actúa como el controlador global de la partida, vinculando señales entre nodos, controlando la lógica de la economía (monedas/compras) y el sistema de guardado.
* **`Obstacle.gd`**: Define el comportamiento individual de cada obstáculo generado, gestionando su movimiento horizontal y emitiendo señales cuando el jugador interactúa con sus áreas de colisión.
