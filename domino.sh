#https://github.com/RustinceHD/ ©2022-2023
#!/bin/bash
# Argumento opcional '-g'
if [[ $# -eq 1 ]]
then
	if [[ $1 = "-g" ]]
		then
		echo "============================="
		echo "Datos de b̸͋̌ɒ̸͓̑ɿ̷͛͠υ̸̽̓ƨ̶̐̓υ̶̐͆:"
		echo "============================="
		
		echo "============================="
		echo "Datos de RustinceHD:"
		echo "============================="
		
		echo
		exit

	else 
		echo "Argumento no valido, el unico argumento valido es -g o en su contrario no introduzca ningun argumento"
		exit  

	fi
fi


function presentacion(){

		echo "================================================================="
		echo "#   _____      _____    ____  ____   ___   ___    _    _____    #"
		echo "#  |   _  \   /  _  \  |    \/    | |   | |   \  | |  /  _  \   #"
		echo "#  |  | |  | |  | |  | |  |\  /|  | |   | | |\ \ | | |  | |  |  #"
		echo "#  |  |_|  | |  |_|  | |  | \/ |  | |   | | | \ \| | |  |_|  |  #"
		echo "#  |_____ /   \_____/  |__|    |__| |___| |_|  \___|  \_____/   #"
		echo "================================================================="
		echo 
		echo ">>By RustinceHD & b̸͋̌ɒ̸͓̑ɿ̷͛͠υ̸̽̓ƨ̶̐̓υ̶̐͆ "
		echo
}

clear
presentacion
echo
echo "Realizando las comprobaciones pertinentes..."
echo "Espere en lo que se inicia el juego :D"
##################################
#VERIFICACION
##################################
if [ ! -f "config.cfg" ]
then
	echo "ERROR NO SE HA ENCONTRADO EL ARCHIVO: config.cfg"
	exit
fi
#Comprobar si se puede leer "config.cfg"
if [ ! -r "config.cfg" ]
then 
	echo "ERROR AL LEER EL ARCHIVO: config.cfg"
	exit
fi 
#Comprobar si se puede escribir "config.cfg
if [ ! -w "config.cfg" ]
then
	echo "ERROR NO SE PUEDE ESCRIBIR EN EL ARCHIVO: config.cfg"
	exit
fi

 

#Comprobar si el formato es el correspondiente en cada caso 
JUGADORES=$(head -n 1 config.cfg | cut -d '=' -f 1)
if [  $JUGADORES != "JUGADORES" ]
then
	echo "ERROR EN LA linea 1 del archivo config.cfg"
	exit
fi

PUNTOSGANADOR=$(head -n 2 config.cfg | tail -1 | cut -d '=' -f 1)
if [  $PUNTOSGANADOR != "PUNTOSGANADOR" ]
then
	echo "ERROR EN LA linea 2 del archivo config.cfg"
	exit
fi

INTELIGENCIA=$(head -n 3 config.cfg | tail -1 | cut -d '=' -f 1)
if [  $INTELIGENCIA != "INTELIGENCIA" ]
then
	echo "ERROR EN LA linea 3 del archivo config.cfg"
	exit
fi
LOG=$(head -n 4 config.cfg | tail -1 | cut -d '=' -f 1)
if [  $LOG != "LOG" ]
then
	echo "ERROR EN LA linea 4 del archivo config.cfg"
	exit
fi

JUGADORES=$(head -n 1 config.cfg | cut -d '=' -f 2) 

if [[ ! $JUGADORES -eq 2 ]] && [[ ! $JUGADORES -eq 3 ]] && [[ ! $JUGADORES -eq 4 ]]
then
	echo "JUGADORES tiene un valor invalido en config.cfg."
	exit
fi 

PUNTOSGANADOR=$(head -n 2 config.cfg | tail -1 | cut -d '=' -f 2)

if [[ $PUNTOSGANADOR -lt 50 ]] || [[ $PUNTOSGANADOR -gt 100 ]]
then
	echo "PUNTOSGANADOR tiene un valor invalido en config.cfg."
	exit
fi

INTELIGENCIA=$(head -n 3 config.cfg | tail -1 | cut -d '=' -f 2)

if [[ ! $INTELIGENCIA -eq 0 ]] && [[ ! $INTELIGENCIA -eq 1 ]]
then 
	echo "INTELIGENCIA tiene un valor invalido en config.cfg."
	exit
fi 

LOG_FILE=$(head -n 4 config.cfg | tail -1 | cut -d '=' -f 2)

while true 
do	
	#read -p "Introduzca la ruta del archivo: (fichero.log) " LOG_FILE		
	mkdir -p $(dirname $LOG_FILE)
	if [ $? -eq 0 ]
	then
		touch $LOG_FILE
	else 
		touch $LOG_FILE
		if [ $? -eq 0 ]
		then
			echo "Algo ha salido mal a la hora de crear la ruta del archivo LOG"
			exit	
		fi	
	fi
	break										
done
############################

#Comprobar si se puede leer "config.cfg"
if [ ! -r $LOG_FILE ]
then 
	echo "ERROR AL LEER EL ARCHIVO DE LOG"
	exit
fi 
#Comprobar si se puede escribir "config.cfg
if [ ! -w $LOG_FILE ]
then
	echo "ERROR NO SE PUEDE ESCRIBIR EN EL ARCHIVO LOG"
	exit
fi
clear


##############################################################################################

###############################################################################################
#VARIABLES GLOBALES
###############################################################################################

###############################################################################################

fichasIzq=(0 0 0 0 0 0 0 1 1 1 1 1 1 2 2 2 2 2 3 3 3 3 4 4 4 5 5 6)
fichasDer=(0 1 2 3 4 5 6 1 2 3 4 5 6 2 3 4 5 6 3 4 5 6 4 5 6 5 6 6)
		   

###############################################################################################

###############################################################################################


###############################################################################
#								   FUNCIONES                        	      #
###############################################################################


###############################
#Menú de configuracion
###############################
function load_animation() {
	chars="|\-/"
	while true; do
		for(( i=0; i<${#chars}; i++ )); do
			sleep 1
			echo -ne "[${chars:$i:1}] $1..." "\r"
		done
	done
}

function menu_config(){

	while true;
	do
		clear
		presentacion
		echo "M) MOSTRAR CONFIGURACION ACTUAL"
		echo "C) CAMBIAR CONFIGURACION"
		echo "S) SALIR"

		read -p "/Domino/Elija su opcion/ >>  " opcion_mj
		case $opcion_mj in

			M)	
				clear
				cat config.cfg
				read -p "Presione enter para volver al menu >>  "
				load_animation "Volviendo al menu" &
				sleep 4
				kill "$!"
				wait "$!" 2>/dev/null
				;;
			C)
				clear
				while true
				do
					read -p "Introduzca el numero de jugadores(2-4): " JUGADORES
					if [[ ! $JUGADORES -eq 2 ]] && [[ ! $JUGADORES -eq 3 ]] && [[ ! $JUGADORES -eq 4 ]]
					then
						echo "ERROR NUMERO INTRODUCIDO INCORRECTO."
					else
						echo "Numero correcto."
						echo "JUGADORES=$JUGADORES"	>  config.cfg
						break
					fi

				done
				
				
				while true
				do
					read -p "Introduzca los puntos con los que se acabara el juego (Entre 50-100): " PUNTOSGANADOR
					if [[ $PUNTOSGANADOR -lt 50 ]] || [[ $PUNTOSGANADOR -gt 100 ]]
					then
						echo "VALOR INCORRECTO, INTRODUZCA VALORES ENTRE 50 Y 100."
					else
						echo "Valor correcto."
						echo "PUNTOSGANADOR=$PUNTOSGANADOR" >> config.cfg
						break
					fi
				done
				
				while true
				do
					read -p "Introduzca si desea nivel de inteligencia de la IA (0 o 1): " INTELIGENCIA
					if [[ ! $INTELIGENCIA -eq 0 ]] && [[ ! $INTELIGENCIA -eq 1 ]]
					then 
						echo "INTELIGENCIA NO EXISTENTE INTRODUZCA UN VALOR ENTRE 0 Y 1."
					else
						echo "Inteligencia introducida correcta."
						echo "INTELIGENCIA=$INTELIGENCIA" >> config.cfg
						break
					fi
				done
				while true 
				do	
					read -p "Introduzca la ruta del archivo: (fichero.log) " LOG_FILE
					
						
						 mkdir -p $(dirname $LOG_FILE)
						 
						if [ $? -eq 0 ]
						then
							touch $LOG_FILE
							echo "Ruta del log introducida."
							echo "LOG=$LOG_FILE" >> config.cfg
						else 
							touch $LOG_FILE
							if [ $? -eq 0 ]
							then
							echo "Algo ha salido mal a la hora de crear la ruta del archivo LOG"
							exit
							fi
						fi
						break
										
				done
				load_animation "Modificando la configuracion" &
				sleep 4
				kill "$!"
				wait "$!" 2>/dev/null
				;;

			S)
				read -p "Presione enter para volver al menu principal >>  "
				load_animation "Volviendo al menu principal" &
				sleep 4
				kill "$!"
				wait "$!" 2>/dev/null
				break
				;;
			*)  
				echo "Opcion incorrecta"
		esac
done
}


function juego(){
	
	clear
	fichasIzq1=()
    fichasDer1=()
    fichasIzq2=()
    fichasDer2=()
    fichasIzq3=()
    fichasDer3=()
    fichasIzq4=()
    fichasDer4=()
	generar_fichas
	
	echo "##################################################"
	#echo "#                STARTING LUIGI...               #"
	echo "#               COMENZANDO RONDA...               #"
	echo "##################################################"
	
	main=()
	rondas=0
	#imprimir_mesa_ini
	ficha_grande
	echo
	
	#echo "Jugador que comienza la partida: $interfaz_jugador"
	
	echo
	echo "El jugador con la la ficha "
	main="[$main_izq|$main_der]"
	echo "Empieza el juego"
	echo ${main[@]}
	sleep 4
	imprimir_mesa
	sleep 4
	game
	
	

}
#################################################################

##################################################################
#	reparte las fichas a los jugadores y el pozo 
##################################################################
function generar_fichas(){
#   ****************************************
	num_ordenado=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27)
	n=28
	pozo=()
	bandera=0
	while true
	do
		rand=$(( $RANDOM % $n ))
		pozo+=(${num_ordenado[$rand]})
		unset num_ordenado[$rand]
		num_ordenado=(${num_ordenado[@]})
		n=$((n-1))
		
		if [[ $n -eq 0 ]]
		then
			break
		fi
	done

	for ((i=0 ; i < 7 ; i++))
	do
		
		fichasIzq1+=(${fichasIzq[(${pozo[$i]})]})
		fichasDer1+=(${fichasDer[(${pozo[$i]})]})

	done

	for ((i=7 ; i < 14 ; i++))
	do
		fichasIzq2+=(${fichasIzq[(${pozo[$i]})]})
		fichasDer2+=(${fichasDer[(${pozo[$i]})]})
		bandera=14
	done 

	if [ $JUGADORES -gt 2 ]
	then
		for ((i=14 ; i < 21 ; i++))
		do
			fichasIzq3+=(${fichasIzq[(${pozo[$i]})]})
			fichasDer3+=(${fichasDer[(${pozo[$i]})]})
			bandera=21
		done 

		if [ $JUGADORES -gt 3 ] 
		then
			for ((i=21 ; i < 28 ; i++))
			do
				fichasIzq4+=(${fichasIzq[(${pozo[$i]})]})
				fichasDer4+=(${fichasDer[(${pozo[$i]})]})
				bandera=28
			done
		fi
	fi
	i=0
	for ((i=0; i < $bandera ; i++))
	do
		unset pozo[$i]
	done
	echo "Pozo actual ${#pozo[@]}"
	

}

function imprimir_mesa_ini(){
	
	
	if [ $JUGADORES -eq 2 ]
	then 
		echo "P4:   CPU3:"
		echo "-----------"
	fi

	if [ $JUGADORES -eq 3 ]
	then 
		echo "P4:   CPU3: CPU2:"
		echo "-----------------"
	fi

	if [ $JUGADORES -eq 4 ]
	then 
		echo "P4:   CPU3: CPU2: CPU1:"
		echo "-----------------------"
	fi
	echo ""
	i=0
	for ((i=0; i < 7; i++))
	do
		if [ $JUGADORES -eq 2 ]
		then 	
			echo "[${fichasIzq1[$i]}|${fichasDer1[$i]}] [${fichasIzq2[$i]}|${fichasDer2[$i]}]"
		fi
			
		if [ $JUGADORES -eq 3 ]
		then
			echo "[${fichasIzq1[$i]}|${fichasDer1[$i]}] [${fichasIzq2[$i]}|${fichasDer2[$i]}] [${fichasIzq3[$i]}|${fichasDer3[$i]}]"
		fi

		if [ $JUGADORES -eq 4 ]
		then 	
			echo "[${fichasIzq1[$i]}|${fichasDer1[$i]}] [${fichasIzq2[$i]}|${fichasDer2[$i]}] [${fichasIzq3[$i]}|${fichasDer3[$i]}] [${fichasIzq4[$i]}|${fichasDer4[$i]}]"
		fi

	done
}

function imprimir_mesa(){

	i=0
	j=0
	echo "Piezas restantes en el pozo ${#pozo[@]}"
	echo ""
	echo "P4:"
	for i in ${fichasIzq1[@]} 
	do 	
		echo -n "[${fichasIzq1[$j]}|${fichasDer1[$j]}]	 "
		j=$((j+1))
	done
	
	j=0
	echo
	echo "CPU3:"
	for i in ${fichasIzq2[@]}
	do
		echo -n "[${fichasIzq2[$j]}|${fichasDer2[$j]}]	 "
		j=$((j+1))
	done

	if [ $JUGADORES -gt 2 ]
	then
		j=0
		echo
		echo "CPU2:"	
		for i in ${fichasIzq3[@]}
		do
			echo -n "[${fichasIzq3[$j]}|${fichasDer3[$j]}]	 "
			j=$((j+1))
		done 

		echo
		if [ $JUGADORES -gt 3 ]
		then
			j=0
			echo "CPU1:"
			for i in ${fichasIzq4[@]}
			do
				echo -n "[${fichasIzq4[$j]}|${fichasDer4[$j]}]	"
				j=$((j+1))
			done
		fi
	fi
}



function ficha_grande(){
	
	max=-1
	JUGADORMAX=1
	flag=0
	pos=0
	flag_cierre=$JUGADORES

##################################

for ((i=0; i < 7; i++))
do
	if [[ ${fichasDer1[$i]} -eq ${fichasIzq1[$i]} ]]
	then
		temp=${fichasDer1[$i]}
		if [[ $max -lt $temp ]]
		then 
			max=$temp;
			JUGADORMAX=1
			flag=1
			pos=$i
			main_izq=${fichasIzq1[$pos]}
			main_der=${fichasDer1[$pos]}
			fi	
		fi
done


for ((i=0; i < 7; i++))
	do
		if [[ ${fichasDer2[$i]} -eq ${fichasIzq2[$i]} ]]
		then
			temp=${fichasDer2[$i]}
			if [[ $max -lt $temp ]]
			then 
				max=$temp;
				JUGADORMAX=2
				flag=1
				pos=$i
				main_izq=${fichasIzq2[$pos]}
				main_der=${fichasDer2[$pos]}
			fi	
			
		fi
done

if [ $JUGADORES -gt 2 ]
then
	for ((i=0; i < 7; i++))
	do
		if [[ ${fichasDer3[$i]} -eq ${fichasIzq3[$i]} ]]
		then
			temp=${fichasDer3[$i]}
			if [[ $max -lt $temp ]]
			then 
				max=$temp;
				JUGADORMAX=3
				flag=1
				pos=$i
				main_izq=${fichasIzq3[$pos]}
				main_der=${fichasDer3[$pos]}
			fi		
		fi
	done
	if [[ $JUGADORES -gt 3 ]]
		then 
		for ((i=0; i < 7; i++))
		do
		if [[ ${fichasDer4[$i]} -eq ${fichasIzq4[$i]} ]]
		then
			temp=${fichasDer4[$i]}
			if [[ $max -lt $temp ]]
			then 
				max=$temp;
				JUGADORMAX=4
				flag=1
				pos=$i
				main_izq=${fichasIzq4[$pos]}
				main_der=${fichasDer4[$pos]}
			fi	
			
		fi
	done

	fi
fi

##################################

	if [ $flag -eq 0 ]
	then 
	JUGADORMAX=0
	max=-1
	for ((i=0; i < 7; i++))
		do
			temp=$((fichasDer1[$i]+fichasIzq1[$i]))
			if [ $max -lt $temp ]
			then 
				max=$temp;
				JUGADORMAX=1
				pos=$i
				main_izq=${fichasIzq1[$pos]}
				main_der=${fichasDer1[$pos]}
				
			fi
			
		done

		for ((i=0; i < 7; i++))
		do
			temp=$((fichasDer2[$i]+fichasIzq2[$i]))
			if [ $max -lt $temp ]
			then 
				max=$temp
				JUGADORMAX=2
				pos=$i
				main_izq=${fichasIzq2[$pos]}
				main_der=${fichasDer2[$pos]}
			fi
				
		done
		
		if [ $JUGADORES -gt 2 ]
		then
			for ((i=0; i < 7; i++))
			do
				temp=$((fichasDer3[$i]+fichasIzq3[$i]))
				if [ $max -lt $temp ]
				then 
					max=$temp
					JUGADORMAX=3
					pos=$
					main_izq=${fichasIzq3[$pos]}
					main_der=${fichasDer3[$pos]}
				fi
				
			done

			if [ $JUGADORES -gt 3 ]
			then 
				for ((i=0; i < 7; i++))
				do
					temp=$((fichasDer4[$i]+fichasIzq4[$i]))
					if [ $max -lt $temp ]
					then 
						max=$temp
						JUGADORMAX=4
						pos=$i
						main_izq=${fichasIzq4[$pos]}
						main_der=${fichasDer4[$pos]}
					fi
				done
			fi
		fi
	fi
	
	imprimir_mesa_ini

	if [[ $JUGADORMAX -eq 1 ]]
    then 
        unset fichasIzq1[$pos]
        unset fichasDer1[$pos]
        fichasIzq1=(${fichasIzq1[@]})
        fichasDer1=(${fichasDer1[@]})
    fi

    if [[ $JUGADORMAX -eq 2 ]]
    then 
        unset fichasIzq2[$pos]
        unset fichasDer2[$pos]
        fichasIzq2=(${fichasIzq2[@]})
        fichasDer2=(${fichasDer2[@]})
    fi

    if [[ $JUGADORMAX -eq 3 ]]
    then 
        unset fichasIzq3[$pos]
        unset fichasDer3[$pos]
        fichasIzq3=(${fichasIzq3[@]})
        fichasDer3=(${fichasDer3[@]})
    fi

    if [[ $JUGADORMAX -eq 4 ]]
    then 
        unset fichasIzq4[$pos]
        unset fichasDer4[$pos]
        fichasIzq4=(${fichasIzq4[@]})
        fichasDer4=(${fichasDer4[@]})
    fi
	
	
	if [[ $JUGADORES -eq 2 ]]
		then
			JUGADORMAX=$((JUGADORMAX+1))
			if [[ $JUGADORMAX -eq 3 ]]
			then
				JUGADORMAX=1
			fi
		fi

		if [[ $JUGADORES -eq 3 ]]
		then
			JUGADORMAX=$((JUGADORMAX+1))
			if [[ $JUGADORMAX -eq 4 ]]
			then
				JUGADORMAX=1
			fi
		fi

		if [[ $JUGADORES -eq 4 ]]
		then
			JUGADORMAX=$((JUGADORMAX+1))
			 if [[ $JUGADORMAX -eq 5 ]]
			then
				JUGADORMAX=1
			fi
		fi


}

function robar(){
	
	pozo=(${pozo[@]})
	pozo_max=${#pozo[@]}
	
	nopiezas=0

	if [[ $JUGADORES -eq 2 ]]
	then

		pieza_robada=${pozo[$rem]}
		unset 'pozo[$rem]'
		pozo=(${pozo[@]})
		if [[ $pozo_max -eq $rem ]]
		then
			nopiezas=1
		fi
	fi

	if [[ $JUGADORES -eq 3 ]]
	then
		pieza_robada=${pozo[$rem]}
		unset 'pozo[$rem]'
		pozo=(${pozo[@]})
		if [[ $pozo_max -eq $rem ]]
		then
			nopiezas=1
		fi

	fi
	
	if [[ $JUGADORES -eq 4 ]]
	then
		echo "NO HAY PIEZAS EN EL POZO!!"
		return
	fi
	
	#let pozo_max-=1
	

	if [[ $JUGADORMAX -eq 1 ]]
	then
		if [[ $nopiezas -eq 0 ]]
		then
			fichasDer1+=(${fichasDer[$pieza_robada]})
            fichasIzq1+=(${fichasIzq[$pieza_robada]})
		fi
	fi
	
	if [[ $JUGADORMAX -eq 2 ]]
    then
    	if [[ $nopiezas -eq 0 ]]
        then
            fichasDer2+=(${fichasDer[$pieza_robada]})
            fichasIzq2+=(${fichasIzq[$pieza_robada]})
        else
        	echo "NO HAY PIEZAS EN EL POZO!!"
        fi
    fi
	
    if [[ $JUGADORMAX -eq 3 ]]
    then
    	if [[ $nopiezas -eq 0 ]]
        then
            fichasDer3+=(${fichasDer[$pieza_robada]})
            fichasIzq3+=(${fichasIzq[$pieza_robada]})
        else
            echo "NO HAY PIEZAS EN EL POZO!!"
        fi
    fi
}

function calcular_ficha_a_insertar(){

	i=0
	posibleIzq=()
	posibleDer=()
	
	i=0
	j=0
	##################
	if [[ $JUGADORMAX -eq 1 ]]
	then
		for i in ${fichasIzq1[@]}
		do
			if [[ fichasIzq1[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasDer1[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasIzq1[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			if [[ fichasDer1[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			j=$((j+1))
		done
	fi

	###############
	if [[ $JUGADORMAX -eq 2 ]]
	then
		for i in ${fichasIzq2[@]}
		do
			if [[ fichasIzq2[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasDer2[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasIzq2[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			if [[ fichasDer2[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			j=$((j+1))
		done
	fi
	#################
	if [[ $JUGADORMAX -eq 3 ]]
	then
		for i in ${fichasIzq3[@]}
		do
			if [[ fichasIzq3[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi
		
			if [[ fichasDer3[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasIzq3[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			if [[ fichasDer3[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			j=$((j+1))
		done
	fi
	#################
	if [[ $JUGADORMAX -eq 4 ]]
	then
	for i in ${fichasIzq4[@]}
		do
			if [[ fichasIzq4[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasDer4[$j] -eq $main_izq ]]
			then
				posibleIzq+=($j)
			fi

			if [[ fichasIzq4[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			if [[ fichasDer4[$j] -eq $main_der ]]
			then
				posibleDer+=($j)
			fi

			j=$((j+1))
		done
	fi
}

function poner(){
	
	flag_cierre=$JUGADORES
	calcular_ficha_a_insertar
	flag_poner=0
	flag_posibles=0
	j=0
	posibleIzq=(${posibleIzq[@]})
	posibleDer=(${posibleDer[@]})

	if [[ $JUGADORMAX -eq 1 ]]
	then
		echo
		if [[ $IzqODer -eq 0 ]]
		then 
			echo
			for i in ${posibleDer[@]} 
			do 	
				if [[ $ficha_a_poner -eq ${posibleDer[$j]} ]]
				then
				#	echo "La ficha si se puede poner 1" 
				#	echo "DEBUG"
				#	echo "Ficha a poner $ficha_a_poner|IzqODer: $IzqODer"
				#	echo  ${posibleDer[@]}
					flag_poner=1
					flag_posibles=0
					break
				else
				#	echo "DEBUG"
				#	echo "La ficha no se puede poner 1"
				#	echo "Ficha a poner $ficha_a_poner|IzqODer: $IzqODer"
				#	echo  ${posibleDer[@]}
					#Llama a la funcion del menu para meter de nuevo los valores 
					#return 
					flag_poner=0
					flag_posibles=1

				fi 
				j=$((j+1))
			
			done
		fi
			
		j=0

		if [[ $IzqODer -eq 1 ]]
		then
			echo
			for i in ${posibleIzq[@]} 
			do 	
				if [[ $ficha_a_poner -eq ${posibleIzq[$j]} ]]
				then
					#echo "La ficha si se puede poner 2" 
					flag_poner=1
					flag_posibles=0
					break
				else
					#echo "DEBUG"
					#echo "La ficha no se puede poner 2"
					#echo "Ficha a poner $ficha_a_poner|IzqODer: $IzqODer"
					#echo  ${posibleIzq[@]} 
					#Llama a la funcion del menu para meter de nuevo los valores 
					flag_poner=0
					flag_posibles=1
				fi 
				j=$((j+1))
			
			done
		fi		
	fi

	#echo "FLAG PONER $flag_poner|FLAG POSIBLES $flag_posibles|FLAG IA $flag_ia"
if [[ $flag_ia -ne 1 ]]
then
	if [[ $flag_posibles -eq 1 ]]
	then
		if [[ ${#posibleDer[@]} -eq 0 ]] && [[ ${#posibleIzq[@]} -eq 0 ]]
		then
			robar
		else
			echo
			echo "Te has equivocado, puedes poner otra ficha"
			sleep 2
			game
			return
		fi
	fi
else
	flag_poner=1
	flag_ia=0
	echo "LA IA VA A PONER FICHA"
fi

	##########################
	if [[ $flag_poner -eq 1 ]]
	then
	
		if [[ $JUGADORMAX -eq 1 ]]
		then

			if [[ $IzqODer -eq 0 ]]
			then 
				if [[ ${fichasIzq1[$ficha_a_poner]} -eq $main_der ]]
				then
					main+=("[${fichasIzq1[$ficha_a_poner]}|${fichasDer1[$ficha_a_poner]}]")
					main_der=(${fichasDer1[$ficha_a_poner]})
					unset 'fichasIzq1[$ficha_a_poner]'
					unset 'fichasDer1[$ficha_a_poner]'
					fichasIzq1=(${fichasIzq1[@]})
					fichasDer1=(${fichasDer1[@]})
				else 
					main+=("[${fichasDer1[$ficha_a_poner]}|${fichasIzq1[$ficha_a_poner]}]")
					main_der=(${fichasIzq1[$ficha_a_poner]})
					unset 'fichasIzq1[$ficha_a_poner]'
					unset 'fichasDer1[$ficha_a_poner]'
					fichasDer1=(${fichasDer1[@]})
					fichasIzq1=(${fichasIzq1[@]})
				fi
			fi
			if [[ $IzqODer -eq 1 ]]
			then
				if [[ ${fichasDer1[$ficha_a_poner]} -eq $main_izq ]]
				then
					main=("[${fichasIzq1[$ficha_a_poner]}|${fichasDer1[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasIzq1[$ficha_a_poner]})
					unset 'fichasIzq1[$ficha_a_poner]'
					unset 'fichasDer1[$ficha_a_poner]'
					fichasIzq1=(${fichasIzq1[@]})
					fichasDer1=(${fichasDer1[@]})
				else
					main=("[${fichasDer1[$ficha_a_poner]}|${fichasIzq1[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasDer1[$ficha_a_poner]})
					unset 'fichasIzq1[$ficha_a_poner]'
					unset 'fichasDer1[$ficha_a_poner]'
					fichasIzq1=(${fichasIzq1[@]})
					fichasDer1=(${fichasDer1[@]})
				fi
			fi
		fi
######################################
		if [[ $JUGADORMAX -eq 2 ]]
		then
			
			if [[ $IzqODer -eq 0 ]]
			then 
				if [[ ${fichasIzq2[$ficha_a_poner]} -eq $main_der ]]
				then
					main+=("[${fichasIzq2[$ficha_a_poner]}|${fichasDer2[$ficha_a_poner]}]")
					main_der=(${fichasDer2[$ficha_a_poner]})
					unset 'fichasIzq2[$ficha_a_poner]'
					unset 'fichasDer2[$ficha_a_poner]'
					fichasIzq2=(${fichasIzq2[@]})
					fichasDer2=(${fichasDer2[@]})
				else 
					main+=("[${fichasDer2[$ficha_a_poner]}|${fichasIzq2[$ficha_a_poner]}]")
					main_der=(${fichasIzq2[$ficha_a_poner]})
					unset 'fichasIzq2[$ficha_a_poner]'
					unset 'fichasDer2[$ficha_a_poner]'
					fichasDer2=(${fichasDer2[@]})
					fichasIzq2=(${fichasIzq2[@]})
				fi
			fi
			if [[ $IzqODer -eq 1 ]]
			then
				if [[ ${fichasDer2[$ficha_a_poner]} -eq $main_izq ]]
				then
					main=("[${fichasIzq2[$ficha_a_poner]}|${fichasDer2[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasIzq2[$ficha_a_poner]})
					unset 'fichasIzq2[$ficha_a_poner]'
					unset 'fichasDer2[$ficha_a_poner]'
					fichasIzq2=(${fichasIzq2[@]})
					fichasDer2=(${fichasDer2[@]})
				else
					main=("[${fichasDer2[$ficha_a_poner]}|${fichasIzq2[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasDer2[$ficha_a_poner]})
					unset 'fichasIzq2[$ficha_a_poner]'
					unset 'fichasDer2[$ficha_a_poner]'
					fichasIzq2=(${fichasIzq2[@]})
					fichasDer2=(${fichasDer2[@]})
				fi
			fi
			
		fi

		if [[ $JUGADORMAX -eq 3 ]]
		then
			if [[ $IzqODer -eq 0 ]]
			then 
				if [[ ${fichasIzq3[$ficha_a_poner]} -eq $main_der ]]
				then
					main+=("[${fichasIzq3[$ficha_a_poner]}|${fichasDer3[$ficha_a_poner]}]")
					main_der=(${fichasDer3[$ficha_a_poner]})
					unset 'fichasIzq3[$ficha_a_poner]'
					unset 'fichasDer3[$ficha_a_poner]'
					fichasIzq3=(${fichasIzq3[@]})
					fichasDer3=(${fichasDer3[@]})
				else 
					main+=("[${fichasDer3[$ficha_a_poner]}|${fichasIzq3[$ficha_a_poner]}]")
					main_der=(${fichasIzq3[$ficha_a_poner]})
					unset 'fichasIzq3[$ficha_a_poner]'
					unset 'fichasDer3[$ficha_a_poner]'
					fichasDer3=(${fichasDer3[@]})
					fichasIzq3=(${fichasIzq3[@]})
				fi
			fi
			if [[ $IzqODer -eq 1 ]]
			then
				if [[ ${fichasDer3[$ficha_a_poner]} -eq $main_izq ]]
				then
					main=("[${fichasIzq3[$ficha_a_poner]}|${fichasDer3[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasIzq3[$ficha_a_poner]})
					unset 'fichasIzq3[$ficha_a_poner]'
					unset 'fichasDer3[$ficha_a_poner]'
					fichasIzq3=(${fichasIzq3[@]})
					fichasDer3=(${fichasDer3[@]})
				else
					main=("[${fichasDer3[$ficha_a_poner]}|${fichasIzq3[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasDer3[$ficha_a_poner]})
					unset 'fichasIzq3[$ficha_a_poner]'
					unset 'fichasDer3[$ficha_a_poner]'
					fichasIzq3=(${fichasIzq3[@]})
					fichasDer3=(${fichasDer3[@]})
				fi
			fi
		fi

		if [[ $JUGADORMAX -eq 4 ]]
		then
			if [[ $IzqODer -eq 0 ]]
			then 
				if [[ ${fichasIzq4[$ficha_a_poner]} -eq $main_der ]]
				then
					main+=("[${fichasIzq4[$ficha_a_poner]}|${fichasDer4[$ficha_a_poner]}]")
					main_der=(${fichasDer4[$ficha_a_poner]})
					unset 'fichasIzq4[$ficha_a_poner]'
					unset 'fichasDer4[$ficha_a_poner]'
					fichasIzq4=(${fichasIzq4[@]})
					fichasDer4=(${fichasDer4[@]})
				else 
					main+=("[${fichasDer4[$ficha_a_poner]}|${fichasIzq4[$ficha_a_poner]}]")
					main_der=(${fichasIzq4[$ficha_a_poner]})
					unset 'fichasIzq4[$ficha_a_poner]'
					unset 'fichasDer4[$ficha_a_poner]'
					fichasDer4=(${fichasDer4[@]})
					fichasIzq4=(${fichasIzq4[@]})
				fi
			fi
			if [[ $IzqODer -eq 1 ]]
			then
				if [[ ${fichasDer4[$ficha_a_poner]} -eq $main_izq ]]
				then
					main=("[${fichasIzq4[$ficha_a_poner]}|${fichasDer4[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasIzq4[$ficha_a_poner]})
					unset 'fichasIzq4[$ficha_a_poner]'
					unset 'fichasDer4[$ficha_a_poner]'
					fichasIzq4=(${fichasIzq4[@]})
					fichasDer4=(${fichasDer4[@]})
				else
					main=("[${fichasDer4[$ficha_a_poner]}|${fichasIzq4[$ficha_a_poner]}]" ${main[@]})
					main_izq=(${fichasDer4[$ficha_a_poner]})
					unset 'fichasIzq4[$ficha_a_poner]'
					unset 'fichasDer4[$ficha_a_poner]'
					fichasIzq4=(${fichasIzq4[@]})
					fichasDer4=(${fichasDer4[@]})
				fi
			fi
		fi
	else
		echo "No tienes para poner, entonces vas a robar ficha"
		
		robar
		return
	fi
}
########ia
function ia(){
    
	flag_ia=0
    move=0
	temp=-1
	calcular_ficha_a_insertar

    if [[ ${#posibleDer[@]} -eq 0 ]] && [[ ${#posibleIzq[@]} -eq 0 ]]
    then
	    #echo ${posibleDer[@]}
		#echo ${posibleIzq[@]}
        flag_ia=0
		if [[ ${#pozo[@]} -ne 0 ]]
		then 
		robar
        ia
		return
		else
		echo "IA pasa de turno"
		flag_cierre=$((flag_cierre-1))

		fi 

    else
		
        if [[ $INTELIGENCIA -eq 0 ]]
        then 
		#	echo ${posibleDer[@]}
	    #	echo ${posibleIzq[@]}
            if [[ ${#posibleDer[@]} -eq 0 ]]
            then
                ficha_a_poner=${posibleIzq[0]}
                IzqODer=1
				flag_ia=1
                poner
                return 
            fi

            if [[ ${#posibleIzq[@]} -eq 0 ]]
            then
                ficha_a_poner=${posibleDer[0]}
                IzqODer=0
				flag_ia=1
                poner
                return 
            fi

            move=$(( $RANDOM % 1 ))

            if [[ $move -eq 1 ]]
            then 
                ficha_a_poner=${posibleDer[0]}
                IzqODer=0
				flag_ia=1
                poner
                return
            else
                ficha_a_poner=${posibleIzq[0]}
                IzqODer=1
				flag_ia=1
                poner
                return 

            fi	
			
     	fi
	#-----------------------------------------------
		if [[ $INTELIGENCIA -eq 1 ]]
        then 
		#	echo ${posibleDer[@]}
	   	#	echo ${posibleIzq[@]}
            if [[ ${#posibleDer[@]} -eq 0 ]]
            then
                if [[ $JUGADORMAX -eq 2 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleIzq[@]}
                    do
                        temp=$((fichasDer2[$i]+fichasIzq2[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleIzq[$j]}
                            IzqODer=1
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi

                if [[ $JUGADORMAX -eq 3 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleIzq[@]}
                    do
                        temp=$((fichasDer3[$i]+fichasIzq3[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleIzq[$j]}
                            IzqODer=1
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi

                if [[ $JUGADORMAX -eq 4 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleIzq[@]}
                    do
                        temp=$((fichasDer4[$i]+fichasIzq4[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleIzq[$j]}
                            IzqODer=1
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi

                poner
                return
            fi

            if [[ ${#posibleIzq[@]} -eq 0 ]]
            then
##
               if [[ $JUGADORMAX -eq 2 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleDer[@]}
                    do
                        temp=$((fichasDer2[$i]+fichasIzq2[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleDer[$j]}
                            IzqODer=0
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi

                if [[ $JUGADORMAX -eq 3 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleDer[@]}
                    do
                        temp=$((fichasDer3[$i]+fichasIzq3[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleDer[$j]}
                            IzqODer=0
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi

                if [[ $JUGADORMAX -eq 4 ]]
                then
                    max=-1
                    j=0
                    for i in ${posibleDer[@]}
                    do
                        temp=$((fichasDer4[$i]+fichasIzq4[$i]))
                        if [[ $max -lt $temp ]]
                        then 
                            max=$temp;
                            ficha_a_poner=${posibleDer[$j]}
                            IzqODer=0
                            flag_ia=1
                            j=$((j+1))
                        fi	        
                    done
                fi
##
                poner
                return
            fi

            
            max=-1
            j=0
#
            if [[ $JUGADORMAX -eq 2 ]]
            then
			 	j=0
                for i in ${posibleIzq[@]}
                do
                    temp=$((fichasDer2[$i]+fichasIzq2[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleIzq[$j]}
                        IzqODer=1
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi
			 
            if [[ $JUGADORMAX -eq 3 ]]
            then
			 	j=0
                for i in ${posibleIzq[@]}
                do
                    temp=$((fichasDer3[$i]+fichasIzq3[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleIzq[$j]}
                        IzqODer=1
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi
			
            if [[ $JUGADORMAX -eq 4 ]]
            then
			 	j=0
                for i in ${posibleIzq[@]}
                do
                    temp=$((fichasDer4[$i]+fichasIzq4[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleIzq[$j]}
                        IzqODer=1
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi

            if [[ $JUGADORMAX -eq 2 ]]
            then
                j=0
                for i in ${posibleDer[@]}
                do
                    temp=$((fichasDer2[$i]+fichasIzq2[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleDer[$j]}
                        IzqODer=0
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi

            if [[ $JUGADORMAX -eq 3 ]]
            then
                j=0
                for i in ${posibleDer[@]}
                do
                    temp=$((fichasDer3[$i]+fichasIzq3[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleDer[$j]}
                        IzqODer=0
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi

            if [[ $JUGADORMAX -eq 4 ]]
            then
				j=0
                for i in ${posibleDer[@]}
                do
                    temp=$((fichasDer4[$i]+fichasIzq4[$i]))
                    if [[ $max -lt $temp ]]
                    then 
                        max=$temp;
                        ficha_a_poner=${posibleDer[$j]}
                        IzqODer=0
                        flag_ia=1
                        j=$((j+1))
                    fi	        
                done
            fi
			#echo "FICHA A PONER $ficha_a_poner|IZQ O DER $IzqODer JUGADORMAX $JUGADORMAX"
            #
            poner
            return
        fi
    fi
	#-----------------------------------------------
}

#FUNCION CREATE LOG
function create_log(){

	TIEMPOPARTIDA=$( expr $fin_partida - $inicio_partida)
	fecha=$(date +"%d%m%y")

	if [[ $JUGADORES -eq 2 ]]
	then
		primero=$(echo $puntos1 $puntos2 | tr " " "-" | sort -n | head -n 2 | tail -1)
		segundo=$(echo $puntos1 $puntos2 | tr " " "-" | sort -n | head -n 1 | tail -1)
		tercero="*"
		cuarto="*"
	fi

	if [[ $JUGADORES -eq 3 ]]
	then
		primero=$(echo $puntos1 $puntos2 $puntos3 | tr " " "\n" | sort -n | head -n 3 | tail -1)
		segundo=$(echo $puntos1 $puntos2 $puntos3 | tr " " "\n" | sort -n | head -n 2 | tail -1)
		tercero=$(echo $puntos1 $puntos2 $puntos3 | tr " " "\n" | sort -n | head -n 1 | tail -1)
		cuarto="*"
	fi

	if [[ $JUGADORES -eq 4 ]]
	then
		primero=$(echo $puntos1 $puntos2 $puntos3 $puntos4 | tr " " "\n" | sort -n | head -n 4 | tail -1)
		segundo=$(echo $puntos1 $puntos2 $puntos3 $puntos4 | tr " " "\n" | sort -n | head -n 3 | tail -1)
		tercero=$(echo $puntos1 $puntos2 $puntos3 $puntos4 | tr " " "\n" | sort -n | head -n 2 | tail -1)
		cuarto=$(echo $puntos1 $puntos2 $puntos3 $puntos4 | tr " " "\n" | sort -n | head -n 1 | tail -1)
	fi

	echo -e "$fecha\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$(date +"%H:%M")\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$JUGADORES\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$TIEMPOPARTIDA\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$rondas\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$INTELIGENCIA\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$PUNTOSGANADOR\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo -e "$WINNER\c" >> $LOG_FILE
	echo -e "|\c" >> $LOG_FILE
	echo  "$primero-$segundo-$tercero-$cuarto" >> $LOG_FILE

}


function game(){

	pozoneg=0
	WINNER=0
	
	#interfaz_ficha=$((ficha_a_poner+1))
	while true
	do
		clear
		imprimir_mesa
		echo ""
		echo "======="
		echo "TABLERO"
		echo "======="
		echo ${main[@]}
		#echo "-$main_izq|$main_der-"
		#echo "La ficha a insertar es $interfaz_ficha"
		echo
		#echo "TE TOCA JUGADOR $interfaz_jugador"
		if [[ $JUGADORMAX -ne 1 ]]
		then 
			ia
		fi
		echo
		sleep 2
		if [ $JUGADORMAX -eq 1 ]
		then
			echo "TE TOCA JUGADOR CUATRO"
			echo ""
			echo "R) ROBAR"
			echo "P) PONER"
			echo "K) PASAR"
			echo
			read -p "/Domino/Game/ >>  " opcion

			case $opcion in
				R)	
				#game$
				
					calcular_ficha_a_insertar
					if [[ ${#posibleDer[@]} -eq 0 ]] && [[ ${#posibleIzq[@]} -eq 0 ]]
					then
						if [[ ${#pozo} -eq 0 ]]
						then 
						echo "Pasando turno, ya que no tienes fichas para poner y no hay fichas disponibles en el pozo!"
						else
						echo "No tienes fichas para poner, procediendo a robar ficha..."
						sleep 2
						robar
						game
						break
						fi 
					
					else
					echo "No puedes robar ficha, ya que tienes una ficha disponible para poner"
					sleep 2
					game
					break
					fi
					;;
				P)
					while true
					do
						echo
						echo "Inserte la posicion de la ficha que quiera insertar:"
						read -p "/Domino/Game/ >>  " ficha_a_poner
						ficha_a_poner=$((ficha_a_poner-1))
						
						if [[ $ficha_a_poner -lt 0 ]] || [[ $ficha_a_poner -gt ${#fichasIzq1[@]} ]]
						then
							echo "POSICION INCORRECTA"
							echo $ficha_a_poner
							continue
						else
							echo
							echo "Elija donde quiere colocar la ficha (1:Izquierda/0:Derecha)"
							read -p "/Domino/Game/ >>  " IzqODer
							if [[ $IzqODer -eq 0 ]] || [[ $IzqODer -eq 1 ]]
							then
								poner
								break
							else
								echo "POSICION INCORRECTA"
								game
							fi
						fi
					done
					sleep 2
					;;
				K)
					calcular_ficha_a_insertar
					if [[ ${#posibleDer[@]} -eq 0 ]] && [[ ${#posibleIzq[@]} -eq 0 ]]
					then
						if [[ ${#pozo} -eq 0 ]]
						then 
						echo "Pasando turno..."
						sleep 2
						else
						echo "No tienes fichas para poner, pero hay fichas disponibles en el pozo!!"
						sleep 2
						game
						break
						fi 
					
					else
					echo "No puedes pasar turno, ya que tienes una ficha disponible para poner"
					sleep 2
					game
					break
					fi
					;;
				*)
					echo "OPCION INCORRECTA"
					sleep 2
					game
					return
					;;
			esac
		fi

		echo ${main[@]}

		if [ $JUGADORES -eq 2 ]
		then
			#echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA-2"
			if [ ${#fichasIzq1[@]} -eq 0 ] || [ ${#fichasIzq2[@]} -eq 0 ] || [ $flag_cierre -lt 0 ]
			then
				calcular_puntos
				
				
			fi
			JUGADORMAX=$((JUGADORMAX+1))
			#
			
			#
			if [ $JUGADORMAX -gt 2 ]
			then
				JUGADORMAX=1
			fi
		fi

		if [ $JUGADORES -eq 3 ]
		then

			#
		#	echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA-3"
			if [ ${#fichasIzq1[@]} -eq 0 ] || [ ${#fichasIzq2[@]} -eq 0 ] || [ ${#fichasIzq3[@]} -eq 0 ] || [ $flag_cierre -lt 0 ]
			then
				calcular_puntos
				
			fi 
			#
			JUGADORMAX=$((JUGADORMAX+1))
			
			if [ $JUGADORMAX -gt 3 ]
			then
				JUGADORMAX=1
			fi
		fi

		if [[ $JUGADORES -eq 4 ]]
		then
			#
		#	echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA-4"
			if [[ ${#fichasIzq1[@]} = 0 ]] || [[ ${#fichasIzq2[@]} = 0 ]] || [[ ${#fichasIzq3[@]} = 0 ]] || [[ ${#fichasIzq4[@]} = 0 ]] || [[ $flag_cierre -lt 0 ]]
			then
				echo ""
				calcular_puntos
			fi 
			#
			JUGADORMAX=$((JUGADORMAX+1))
			
			if [[ $JUGADORMAX -gt 4 ]]
			then
				JUGADORMAX=1
			fi
		fi
		
	done
	
}

function calcular_puntos(){
	
    puntox=()
	WINNER=0
    j=0
    i=0
    puntos1=0
	for i in ${fichasDer1[@]}
	do
		puntos1=$((puntos1+${fichasDer1[$j]}+${fichasIzq1[$j]}))
		j=$((j+1))
	done
    puntox+=($puntos1)
    i=0
	j=0
    puntos2=0
	for i in ${fichasDer2[@]}
	do
		puntos2=$((puntos2+${fichasDer2[$j]}+${fichasIzq2[$j]}))

		j=$((j+1))
	done
    puntox+=($puntos2)

    if [[ $JUGADORES -gt 2 ]]
    then
        puntos3=0
        i=0
        j=0
        for i in ${fichasDer3[@]}
        do
            puntos3=$((puntos3+${fichasDer3[$j]}+${fichasIzq3[$j]}))
            j=$((j+1))
        done
        puntox+=($puntos3)
        if [[ $JUGADORES -gt 3 ]]
        then
            puntos4=0
            i=0
            j=0
            for i in ${fichasDer4[@]}
            do
                puntos4=$((puntos4+${fichasDer4[$j]}+${fichasIzq4[$j]}))
                j=$((j+1))
            done
            puntox+=($puntos4)  
        fi
    fi


    ronda_ganador=0
    min=$puntos1
    ronda_ganador=1
    for ((i=0 ; i < ${#puntox[@]} ;i++))
    do
        if [[ $min -gt ${puntox[$i]} ]]
        then 
            min=${puntox[$i]}
            ronda_ganador=$((i+1))
		fi 
    done
	#################################
	
		if [[ ${#fichasDer1[@]} -eq 0 ]] 
		then 
 			ronda_ganador=1
		fi 
		if [[ ${#fichasDer2[@]} -eq 0 ]] 
		then 
 			ronda_ganador=2
			
		fi
		if [ $JUGADORES -gt 2 ] 
		then
			if [[ ${#fichasDer3[@]} -eq 0 ]] 
			then 
				ronda_ganador=3
			fi 
			if [ $JUGADORES -gt 3 ]
			then
				if [[ ${#fichasDer4[@]} -eq 0 ]] 
				then 
					ronda_ganador=4
				fi 
			fi
		fi
	##################################

    if [[ $ronda_ganador -eq 1 ]]
    then
        puntosG1=$((puntosG1+puntos2+puntos3+puntos4))
    fi
    if [[ $ronda_ganador -eq 2 ]]
    then
        puntosG2=$((puntosG2+puntos1+puntos3+puntos4))
    fi
    if [[ $ronda_ganador -eq 3 ]]
    then
        puntosG3=$((puntosG3+puntos2+puntos1+puntos4))
    fi
    if [[ $ronda_ganador -eq 4 ]]
    then
        puntosG4=$((puntosG4+puntos2+puntos3+puntos1))
    fi

#########################################	
	
	if [ $puntosG1 -lt $PUNTOSGANADOR ] && [ $puntosG2 -lt $PUNTOSGANADOR ] && [ $puntosG3 -lt $PUNTOSGANADOR ] && [ $puntosG4 -lt $PUNTOSGANADOR ]
	then 
		clear
		rondas=$((rondas+1))
		echo "Fin de una ronda, puntos obtenidos:  P4: $puntosG1 CPU3: $puntosG2 CPU2: $puntosG3 CPU1: $puntosG4 | Puntos necesarios para finalizar: $PUNTOSGANADOR"
		echo "COMENZANDO RONDA "
		sleep 3
		juego
		return
	else
		fin_partida=$(nawk "BEGIN{print srand}")
		if [[ $puntosG1 -ge $PUNTOSGANADOR ]]
		then
			WINNER=1
		fi
		if [[ $puntosG2 -ge $PUNTOSGANADOR ]]
		then
			WINNER=2
		fi
		if [[ $puntosG3 -ge $PUNTOSGANADOR ]]
		then 
			WINNER=3
		fi
		if [[ $puntosG4 -ge $PUNTOSGANADOR ]]
		then
			WINNER=4
		fi
		create_log
		clear
		echo "Fin de la partida, puntos obtenidos: P4: $puntosG1 CPU3: $puntosG2 CPU2: $puntosG3 CPU1: $puntosG4 | Puntos necesarios para finalizar: $PUNTOSGANADOR"
		echo 
		
		echo "-----FIN DE LA EXPERIENCIA-----"
		sleep 2
		clear 
		echo "Easter_egg: I EAT LIKE A PRO -- LUIGI - 01/11/2022 - 22:13"
		clear
		exit
	fi

	
} 

#FUNCION ESTADISTICAS
function estadisticas(){

	lineLOG=$( wc -l $LOG_FILE | cut -f 8 -d " ")

	if test $lineLOG -eq 0
	then
	    clear 
		echo "El fichero esta vacio"
		load_animation "Volviendo al menu..." &
		sleep 4
		kill "$!"
		wait "$!" 2> /dev/null
		return
	fi

	MPUNTOSGANADORES=$(echo "scale=2; $(cat $LOG_FILE | cut -d "|" -f 7 | xargs | tr " " "+" | bc)/$lineLOG" | bc)
	MRONDAS=$(echo "scale=2; $(cat $LOG_FILE | cut -d "|" -f 5 | xargs | tr " " "+" | bc)/$lineLOG" | bc)
	MTIEMPO=$(echo "scale=2; $(cat $LOG_FILE | cut -d "|" -f 4 | xargs | tr " " "+" | bc)/$lineLOG" | bc)
	TIEMPOTOTAL=$(cat $LOG_FILE | cut -d "|" -f 4 | xargs | tr " " "+" | bc)
	PORCENTAJEINT=$(echo $(echo "scale=2;" $(cat $LOG_FILE | cut -d '|' -f 6 | xargs | sed -e 's/ /+/g' | bc)/$lineLOG | bc -l)*100 | bc)
	SUMPUNTOS=$(echo "scale=2; $(cat $LOG_FILE | cut -d "|" -f 9 | xargs | tr "-" "+" | tr " " "+" | tr "*" "0" | bc)/$lineLOG" | bc)

	clear
	echo "======================================"
	echo "+    |--------------------------|    +"
	echo "+    |       ESTADISTICAS       |    +"
	echo "+    |--------------------------|    +"
	echo "======================================"
	echo ""
	echo "- PARTIDAS JUGADAS: $lineLOG"
	echo "- MEDIA DE PUNTOS GANADORES: $MPUNTOSGANADORES"
	echo "- MEDIA DE RONDAS: $MRONDAS"
	echo "- MEDIA DE TIEMPO: $MTIEMPO"
	echo "- TIEMPO TOTAL: $TIEMPOTOTAL"
	echo "- PORCENTAJE DE PARTIDAS CON INTELIGENCIA ACTIVADA: $PORCENTAJEINT"
	echo "- SUMA DE LOS PUNTOS DE TODOS LOS JUGADORES EN LAS PARTIDAS JUGADAS: $SUMPUNTOS"
	echo ""
	read -p "/Domino/Estadisticas/Pulse cualquier tecla para continuar >>  "
	clear
	load_animation "Volviendo al menu..." &
	sleep 4
	kill "$!"
	wait "$!" 2>/dev/null

}

#FUNCION CLASIFICACION
function clasificacion(){
	lineLOG=$( wc -l $LOG_FILE | cut -f 8 -d " ")

	if test $lineLOG -eq 0
	then
	    clear 
		echo "El fichero esta vacio"
		load_animation "Volviendo al menu..." &
		sleep 4
		kill "$!"
		wait "$!" 2> /dev/null
		return
	fi
	PARTIDACORTA=$(grep $(cat $LOG_FILE | cut -d "|" -f 4 | sort -n | head -n 1) $LOG_FILE | head -n 1)
	PARTIDALARGA=$(grep $(cat $LOG_FILE | cut -d "|" -f 4 | sort -rn | head -n 1) $LOG_FILE | head -n 1)
	MASRONDAS=$(grep $(cat $LOG_FILE | cut -d "|" -f 5 | sort -rn | head -n 1) $LOG_FILE | head -n 1)
	MENOSRONDAS=$(grep $(cat $LOG_FILE | cut -d "|" -f 5 | sort -n | head -n 1) $LOG_FILE | head -n 1)
	MAXPUNTOSGANADOR=$(grep $(cat $LOG_FILE | cut -d "|" -f 7 | sort -nr | head -n 1) $LOG_FILE | head -n 1)
	MASPUNTOSPL=0
	###############
	for (( i=1; i<=$(wc -l $LOG_FILE | cut -f 8 -d " "); i++ ))
	do
		temp_clas=$(head -n $i $LOG_FILE | tail -1 | cut -d "|" -f 9 | tr "-" "+" | tr "*" "0" | bc | sort -nr | head -n 1)
		if [[ $temp_clas -gt $MASPUNTOSPL ]]
		then
			MASPUNTOSPL=$temp_clas
			MASPUNTOSPL_index=$i
		fi
	done
	
	PUNTOSGANADORES=$(head -n $MASPUNTOSPL_index $LOG_FILE | tail -1 )
		
	###############

#######################
	clear
	echo "========================================"
	echo "+    |----------------------------|    +"
	echo "+    |        CLASIFICACION       |    +"
	echo "+    |----------------------------|    +"
	echo "========================================"
	echo ""
	echo "- LA PARTIDA MAS CORTA: $PARTIDACORTA"
	echo "- LA PARTIDA MAS LARGA: $PARTIDALARGA"
	echo "- LA PARTIDA CON MAS RONDAS: $MASRONDAS"
	echo "- LA PARTIDA CON MENOS RONDAS: $MENOSRONDAS"
	echo "- LA PARTIDA CON MAYORES PUNTOS PARA GANAR: $MAXPUNTOSGANADOR"
	echo "- LA PARTIDA CON MAYORES PUNTOS DE TODOS LOS JUGADORES: $PUNTOSGANADORES"
	
	read -p "/Domino/Estadisticas/Pulse cualquier tecla para continuar >>  "
	clear
	load_animation "Volviendo al menu..." &
	sleep 4
	kill "$!"
	wait "$!" 2>/dev/null

}

######################
#        MAIN        #
######################

while true
do
		clear
		presentacion
		echo "M) MODIFICAR CONFIGURACION"						
		echo "J) JUGAR"
		echo "F) CLASIFICACION"
		echo "E) ESTADISTICAS"
		echo "S) SALIR"

	 	read -p "/Domino/Elija su opcion/ >>  " opcion
		case $opcion in 
			M)
				menu_config
				;;
			J)
				
				inicio_partida=$(nawk "BEGIN{print srand}")
				
				puntosG1=0
				puntosG2=0
				puntosG3=0
				puntosG4=0
				juego
				;;
		    F)
				clasificacion
				;;
		    E)
				estadisticas
				;;
		    S)
				echo "--FIN DE LA EXPERIENCIA--"
				exit 
				;;
			*)
				echo "Opcion incorrecta"
				sleep 1
		esac
done




exit 0
