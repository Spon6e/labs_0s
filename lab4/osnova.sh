#!/bin/bash
line="y"
while [ $line = "y" ]
do
	echo "Выведу имя студента с наибольшим количеством неудачных попыток сдачи тестов"
	echo "---------------------------------------------------------------------------"
	echo "1 - Худший в мире по Пивоварению"
	echo "2 - Худший в мире по Уфологии"
	echo "3 - Худший в мире по совокупности"
	echo "4 - Худший среди худших(главный по позорам)"
	read -r vibor


	if [ $vibor = "1" ] 
	then
		echo "Введите номер группы"
		read -r grupa
		xdd=$(echo $grupa | grep -e A-0[69]-[0-9][0-9] -e Ae-21-21)
		if [ ${#xdd} -ge 1 ]
		then
xd=$(grep $grupa labfiles/Пивоварение/tests/*)
			if [ ${#xd} -ge 1 ]
			then
grep $grupa labfiles/Пивоварение/tests/* -h | sed '/[3-5]$/d' | sort | sh logika.sh
			else
				echo "Нет данных о группе " $grupa
			fi
		else
			echo "Нет такой группы - " $grupa
		fi
	

	elif [ $vibor = 2 ]
	then
                echo "Введите номер группы"
                read -r grupa
xdd=$(echo $grupa | grep -e A-0[69]-[0-9][0-9] -e Ae-21-21)
                if [ ${#xdd} -ge 1 ]
                then
xd=$(grep $grupa labfiles/Уфология/tests/*)
                        if [ ${#xd} -ge 1 ]
                        then
grep $grupa labfiles/Уфология/tests/* -h | sed '/[3-5]$/d' | sort | sh logika.sh
                        else
                                echo "Нет данных о группе " $grupa
                        fi
                else
                        echo "Нет такой группы - " $grupa
                fi


		elif [ $vibor = 3 ]
        	then
                	echo "Введите номер группы"
                	read -r grupa
xdd=$(echo $grupa | grep -e A-0[69]-[0-9][0-9] -e Ae-21-21)
                	if [ ${#xdd} -ge 1 ]
                	then
xd=$(grep $grupa labfiles/Уфология/tests/* labfiles/Пивоварение/tests/* )
                        if [ ${#xd} -ge 1 ]
                        then
grep $grupa labfiles/Уфология/tests/* labfiles/Пивоварение/tests/* -h | sed '/[3-5]$/d' | sort | sh logika.sh
                        else
                                echo "Нет данных о группе " $grupa
                        fi
                else
                        echo "Нет такой группы - " $grupa
                fi



		elif [ $vibor = 4 ]
                then
grep -h '.*' labfiles/Уфология/tests/* -h | sed '/[3-5]$/d' | sort | sh logika.sh



	fi
	echo "<-------------------------------------->"
	echo "Продолжим?(y/n)"
	read -r line
done
echo "GG"
