%declaracion de librerias

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
:-pce_image_directory('./img').
:-dynamic color/2.

% metodo principal para iniciar la interfaz grafica, declaracion de
% botones, labels, y la posicion en pantalla.
% Imagenes

resource(pc, image, image('pc_01.jpg')).
nueva_imagen(Ventana, Imagen):- new(Figura, figure),
			       new(Bitmap, bitmap(resource(Imagen),@on)),
			        send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(100,150)).
inicio:-

	new(Menu, dialog('Sistema Experto de fallas en PC', size(900,800))),
	new(L,label(nombre,'Software para predecir fallas técnicas en computadoras')),
	new(A,label(nombre,'Santos Fierro 15540172\nJonahtan Ramirez 15551422\nIlse Baca 15551446\nJhonatan Villegas 15551409')),
	new(@texto,label(nombre,'Responde este cuestionario para resolver tu falla')),
	new(@respl,label(nombre,'')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('Realizar test',message(@prolog,botones))),


        nueva_imagen(Menu, pc),
	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(30,20)),
	send(Menu,display,A,point(100,260)),
	send(Menu,display,@boton,point(150,150)),
	send(Menu,display,@texto,point(43,60)),
	send(Menu,display,Salir,point(150,360)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

%solucion a las fallas de acuerdo a las reglas de diagnostico

fallas('Se recomienda un formateo:
      Debe de reinstalar por completo el sistema operativo,
      asÃ­ se eliminarán los archivos que se acumulan con el
      tiempo,se desfragmenta el disco duro y funcionará¡
      de una mejor manera'):-lento,!.

fallas('realizar un cambio de ventilador:
        los ventiladores de las PC duran un tiempo y se
	descomponen, se recomienda cambiar el ventilador
	y la pasta tÃ©rmica del procesador para un mejor
	rendmiento y cero calentamiento'):-sobrecalentamiento,!.

fallas('La solucion es hacer una limpieza a tu PC:
	tienes que empezar por desatornillar la tapa lateral del
	aparato para acceder a su interior. Si te ves capaz, lo mejor es
	que extraigas todos los disipadores, ventiladores y tarjeta
	gráfica para limpiar el polvo que se queda ahí incrustado
	de forma concienzuda;si no sabes cómo o no te atreves, utiliza
	la aspiradora y la brocha para ir poco a poco, limpiando muy
	bien las aspas de los ventiladores, los filtros antipolvo y las
	ranuras que te vayas encontrando. Cuando acabes, vuelve a
	poner la tapa en su lugar.'):-sucio,!.

fallas('llego la hora de cambiar tus pastillas de freno:
	si se escucha un chillido agudo al frenar es tiempo
        de cambiar las pastillas de los frenos, para ello hay
	que levantar con un gato hidraulico el lado del freno
	donde se va a cambiar, con una llave inglesa y una
	matraca aflojar los cubre pastillas y sacar las patillas
	antiguas y reponerlas con las nuevas, colocar todo en su
	lugar y bla bla bla. '):-pantalla_azul,!.

fallas('posiblemente tu auto pasara a mejor vida:
	esta luz puede indicar varias fallas en el sistema de la ECU,
	las pricipales son fallas de sensores, servicio de motor,
	catalizador, etc. si se cuenta con un escaner automotriz puede
	borrarse la falla pero esto no arregla el problema, para ello
	acuda con su mecanico certificado por los aliens.'):-congelado,!.

fallas('si tus archivos desaparecieron es porque tienes un virus
	ejecuta este comando en CMD para recuperar tus arhivos:
	attrib /d /s -r -h -s C:/*.*
	una vez que ya tengas de nuevo todo tus archivos,
	formatea o elimina archivos lo mas que puedas, luego
	descarga un antivirus, instalalo y ejecuta el analisis
	para poder desaserte del virus'):-virus,!.

fallas('Debes reemplazar el cable de corriente que va de la
	fuente de alimentación al conector, posiblemente esté
	dañado'):- cable_corriente,!.
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
	pregunta('Se calienta muy rápido?'),
	pregunta('Se apaga cuando se calienta mucho?'),
	pregunta('tiene problemas de rendimiento en general?').

pantalla_azul:- actualizar_drivers,
	pregunta('ha aparecido con frecuencia la pantalla azul?'),
	pregunta('Aparece el error 0x0000000A?'),
	pregunta('no ha actualizado recientemente sus drivers?'),
	pregunta('no ha formateado en más de 1 año su PC?'),
	pregunta('falló alguna actualización?').

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
	pregunta('notas un comportamiento extraño en tu pc?'),
	pregunta('sientes que tu pc tiene un mal rendimiento?'),
	pregunta('se han instalado apliaciones sin tu permiso?').
cable_corriente:- no_enciende,
	pregunta('Se escucha un ruido al conectar a la corriente?'),
	pregunta('Notas que puedes ver los cables al interior
	del cable de corriente?'),
	pregunta('La pantalla sí enciende pero el CPU, no?').
reinstalar:- no_abre_programa,
	pregunta('Aparace un mensaje de error al iniciarlo?'),
	pregunta('Se cierra solo el programa?'),
	pregunta('Se traba o está muy lento?').
cambiar_puerto:- falla_usb,
	pregunta('Le da corriente a la memoria?'),
	pregunta('cuando la conectas aparece un mensaje de error?'),
	pregunta('notas que está suelto el puerto?').
cambiar_flex:- falla_pantalla,
	pregunta('Parpadea la pantalla cuando la estás usando?'),
	pregunta('Aparece todo en negro?'),
	pregunta('Es laptop?').


%identificador de falla que dirige a las preguntas correspondientes

formateo:-pregunta('está lenta tu PC?'),!.
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
preguntar(Problema):- new(Di,dialog('Diagnóstico de PC')),
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
	send(@texto,selection('la solucion es ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).




























