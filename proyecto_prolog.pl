%declaracion de librerias

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
:-pce_image_directory('./img').
:-dynamic color/2.

% Imagenes

resource(pc, image, image('pc_01.jpg')).
nueva_imagen(Ventana, Imagen):- new(Figura, figure),
			        new(Bitmap, bitmap(resource(Imagen),@on)),
			        send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(450,350)).


% metodo principal para iniciar la interfaz grafica, declaracion de
% botones, labels, y la posicion en pantalla.

inicio:-

	new(Menu, dialog('Sistema Experto de fallas en PC', size(950,850))),
	new(L,label(nombre,'Software para predecir fallas t�cnicas en computadoras')),
	new(A,label(nombre,'Santos Fierro 15540172\nJonahtan Ramirez 15551422\nIlse Baca 15551446\nJhonatan Villegas 15551409')),
	new(@texto,label(nombre,'Responde este cuestionario para resolver tu falla')),
	new(@respl,label(nombre,'')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('Realizar test',message(@prolog,botones))),
	new(@texto2, label(nombre,'')),


        nueva_imagen(Menu, pc),
	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(30,10)),
	send(Menu,display,A,point(100,360)),
	send(Menu,display,@boton,point(150,170)),
	send(Menu,display,@texto,point(43,25)),
	send(Menu,display,Salir,point(150,460)),
	send(Menu,display,@respl,point(20,200)),
	send(Menu,display,@texto2,point(43, 185)),
	send(Menu,open_centered).

%solucion a las fallas de acuerdo a las reglas de diagnostico

fallas('Se recomienda un formateo:
        Debe de reinstalar por completo el sistema operativo,
        as� se eliminar�n los archivos que se acumulan con el
        tiempo,se desfragmenta el disco duro y funcionar�
        de una mejor manera'):-lento,!.

fallas('realizar un cambio de ventilador:
        los ventiladores de las PC duran un tiempo y se
	descomponen, se recomienda cambiar el ventilador
	y la pasta t�rmica del procesador para un mejor
	rendmiento y cero calentamiento'):-sobrecalentamiento,!.

fallas('La solucion es hacer una limpieza a tu PC:
	tienes que empezar por desatornillar la tapa lateral del
	aparato para acceder a su interior. Si te ves capaz, lo mejor es
	que extraigas todos los disipadores, ventiladores y tarjeta
	gr�fica para limpiar el polvo que se queda ah� incrustado
	de forma concienzuda;si no sabes c�mo o no te atreves, utiliza
	la aspiradora y la brocha para ir poco a poco, limpiando muy
	bien las aspas de los ventiladores, los filtros antipolvo y las
	ranuras que te vayas encontrando. Cuando acabes, vuelve a
	poner la tapa en su lugar.'):-sucio,!.

fallas('Tu PC pasar� a mejor vida, recomendamos hacerle un funeral.
	mentira, debes instalar todas las actulizacione disponibles
	de tus drives o del mismo sistema operativo, cuando pasa esto
	significa que algun driver est� fallando o un archivo del mismo
	'):-pantalla_azul,!.

fallas('Puede que sea el momento adecuando para cambiar de PC, ya que
        no tiene la suficiente memoria o procesador para correr tus
	programas habituales.'):-congelado,!.

fallas('si tus archivos desaparecieron es porque tienes un virus
	ejecuta este comando en CMD para recuperar tus arhivos:
	attrib /d /s -r -h -s C:/*.*
	una vez que ya tengas de nuevo todo tus archivos,
	formatea o elimina archivos lo mas que puedas, luego
	descarga un antivirus, instalalo y ejecuta el analisis
	para poder desaserte del virus'):-virus,!.

fallas('Debes reemplazar el cable de corriente que va de la
	fuente de alimentaci�n al conector, posiblemente est�
	da�ado'):- cable_corriente,!.

fallas('Debes reinstalar el programa o checar la compatibilidad
        con tu sistema operativo para poder iniciarlo.'):-reinstalar,!.

fallas('Debes de reemplazar tu puerto USB para poder volver
        a usarlo o limpiarlo en su defecto.'):- cambiar_puerto,!.

fallas('Debes cambiar el flex de la pantalla, para ello debes
         desatornillar correctamente la laptop y remover el flex
	 de la pantalla para poder reemplazarlo adecuandamente.'):-cambiar_flex,!.


fallas('sin resultados! No tenemos el suficiente tiempo para resolver
	tu problema').

% preguntas para resolver las fallas con su respectivo identificador de
% falla
lento:- formateo,
	pregunta('Tarda mucho en cargar los programas?'),
	pregunta('Cuando abre un programa, se queda congelado?'),
	pregunta('Tarda mucho tiempo en encender? '),
	pregunta('No puede tener abiertos varios programas porque
	se congela la pantalla?'),
	pregunta('Se siente lenta en general? ').

sobrecalentamiento:- cambio_ventilador,
	pregunta('Hace mucho ruido el ventilador de tu PC?'),
	pregunta('Se calienta muy r�pido?'),
	pregunta('Se apaga cuando se calienta mucho?'),
	pregunta('tiene problemas de rendimiento en general?').

pantalla_azul:- actualizar_drivers,
	pregunta('ha aparecido con frecuencia la pantalla azul?'),
	pregunta('Aparece el error 0x0000000A?'),
	pregunta('no ha actualizado recientemente sus drivers?'),
	pregunta('no ha formateado en m�s de 1 a�o su PC?'),
	pregunta('fall� alguna actualizaci�n?').

sucio:- limpieza,
	pregunta('tu ventilador llega a atascarse?'),
	pregunta('tu pc comienza a elevar su temperatura rapidamente al encenderla
	?'),
	pregunta('tu PC se apaga de vez en cuando?').

congelado:- administrador_tareas,
	pregunta('no responde tu PC?'),
	pregunta('No puedes cerrar un programa?').

virus:- antivirus,
	pregunta('Tus archivos desaparecion?'),
	pregunta('notas un comportamiento extra�o en tu pc?'),
	pregunta('sientes que tu pc tiene un mal rendimiento?'),
	pregunta('se han instalado apliaciones sin tu permiso?').
cable_corriente:- no_enciende,
	pregunta('Se escucha un ruido al conectar a la corriente?'),
	pregunta('Notas que puedes ver los cables al interior
	del cable de corriente?'),
	pregunta('La pantalla s� enciende pero el CPU, no?').
reinstalar:- no_abre_programa,
	pregunta('Aparace un mensaje de error al iniciarlo?'),
	pregunta('Se cierra solo el programa?'),
	pregunta('Se traba o est� muy lento?').
cambiar_puerto:- falla_usb,
	pregunta('Le da corriente a la memoria?'),
	pregunta('cuando la conectas aparece un mensaje de error?'),
	pregunta('notas que est� suelto el puerto?').
cambiar_flex:- falla_pantalla,
	pregunta('Parpadea la pantalla cuando la est�s usando?'),
	pregunta('Aparece todo en negro?'),
	pregunta('Es laptop?').


%identificador de falla que dirige a las preguntas correspondientes

formateo:-pregunta('est� lenta tu PC?'),!.
cambio_ventilador:-pregunta('Se calienta mucho?'),!.
actualizar_drivers:-pregunta('Te aparece pantalla azul?'),!.
limpieza:-pregunta('hace ruidos al iniciar?'),!.
administrador_tareas:-pregunta('Aparece una pantalla negra?'),!.
antivirus:-pregunta('Te aparecen muchos accesos directos?'),!.
no_enciende:-pregunta('Tu PC no enciende?'),!.
no_abre_programa:-pregunta('No abre un programa?'),!.
falla_usb:-pregunta('No detecta tu memoria USB?'),!.
falla_pantalla:-pregunta('Falla tu pantalla?'),!.

% proceso del diagnostico basado en preguntas de si y no, cuando el
% usuario dice si, se pasa a la siguiente pregunta del mismo ramo, si
% dice que no se pasa a la pregunta del siguiente ramo
% (motor,frenos,etc.)

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagn�stico de PC')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

% cada vez que se conteste una pregunta la pantalla se limpia para
% volver a preguntar

pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% proceso de eleccion de acuerdo al diagnostico basado en las preguntas
% anteriores

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto2,selection('LA SOLUCION ES:')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).
fin:-halt.




























