#!/bin/bash

# Establece la carpeta del proyecto como variable de entorno
export DIR_PROYECTO=~/"OneDrive - Benemérita Universidad Autónoma de Puebla"/"Women in tech"/"Ciencia de datos"/productividad
# Navega a la carpeta del proyecto
cd $DIR_PROYECTO

# Pregunta al usuario que estado quiere revisar
echo ¿Qué estado quiere revisar? Introduce el nombre completo en MAYÚSCULAS:
read estado

# Ejecuta un script de R para limpiar y preparar los datos
# Suponiendo que el script también genera un archivo CSV como salida
Rscript limpiar_datos.R $estado
echo Limpieza de datos, lista.

# Utiliza argumentos en funciones, pipes y comodines para procesar archivos de datos
# Por ejemplo, encontrar y listar archivos CSV modificados recientemente
echo Se usarán los siguientes archivos:
find . -name "*.csv" -mtime -1 -print | xargs ls -lh

# Genera el reporte en RMarkdown, pasando argumentos si es necesario
Rscript -e "rmarkdown::render('Sesion3_Proyecto.Rmd', output_file='reporte_proyecto.md')"

# Inicializa Git si aún no se ha hecho
git init productividad -b main

# Añade el reporte generado al repositorio de Git
git add reporte_proyecto.md

# Commit del reporte al repositorio local de Git
git commit -m "Añade reporte generado automáticamente"

# Sube el reporte al repositorio de GitHub
git push --set-upstream origin master

# Ejecutable Unix para notificar fin del proceso
echo "Reporte generado y subido a GitHub exitosamente."
