#!/bin/bash
maximum=1
tecuch=1
read -r firstSTR
imaCH=$(echo "$firstSTR" | sed 's/[0-9]*,//;s/,.*//')  # Извлекаем имя из строки
masIM+=("$imaCH")
masStrok+=("$firstSTR")

# Обработка остальных строк
while read -r stroka; do
    name=$(echo "$stroka" | sed 's/[0-9]*,//;s/,.*//')  # Извлекаем имя из строки

    if [ "$imaCH" == "$name" ]; then
        ((tecuch++))
    else
        if [ $tecuch -gt $maximum ]; then
            unset masIM
            maximum=$tecuch
            masIM=("$imaCH")
        elif [ $tecuch -eq $maximum ]; then
            masIM+=("$imaCH")
        fi

        imaCH=$name
        tecuch=1
    fi
    masStrok+=("$stroka")
done

# Проверка последнего элемента
if [ $tecuch -gt $maximum ]; then
    unset masIM
    maximum=$tecuch
    masIM=("$imaCH")
elif [ $tecuch -eq $maximum ]; then
    masIM+=("$imaCH")
fi

# Вывод результата
echo "Наибольшее количество пересдач ($maximum) имеет(ют) студент(ы):"
for i in "${masIM[@]}"; do
    echo "$i"
done
for stroka in "${masStrok[@]}"; do
    for IMA in "${masIM[@]}"; do
        if [[ "$stroka" == *"$IMA"* ]]; then
            echo "$stroka"
            break
        fi
    done
done