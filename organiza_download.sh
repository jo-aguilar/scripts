#!/bin/sh
#script para organização do diretório /Downloads para que seus arquivos,
#segundo seu tipo, sejam organizados em subdiretórios

download_dir=$HOME/Downloads
pdf_dir=$HOME/Downloads/pdf
pacotes_dir=$HOME/Downloads/pacotes
imagens_dir=$HOME/Downloads/imagens

#criação de diretórios dentro de /Downloads para que os arquivos
#do diretório possam ser organizados por tipo
if [ ! -d "$pdf_dir" ]; then
	mkdir "$pdf_dir"
	echo "Downloads/pdf criado"
fi

if [ ! -d "$imagens_dir" ]; then
	mkdir "$imagens_dir"
	echo "Downloads/imagens criado"
fi

if [ ! -d "$pacotes_dir" ]; then
	mkdir "$pacotes_dir"
	echo "Downloads/pacotes criado"
fi


#envia os arquivos por tipo para seus respectivos diretórios

extensao=" "
caminho=" "

cd "$download_dir"

organiza(){
	condicao=`find . -type f '-name' '$extensao'`
	if [ ${#condicao[@]} -gt 0 ]; then
		mv ${extensao} ${caminho}
		echo "$extensao movido para $caminho"
	else
		echo "sem $extensao para se mover"
	fi	
} 

extensao="*.pdf"
caminho="${pdf_dir}"
organiza

extensao="*.png"
caminho=$imagens_dir
organiza

extensao="*.jpg"
organiza

extensao="*.jpeg"
organiza

extensao="*.iso"
caminho=$pacotes_dir
organiza

extensao="*.gz"
organiza

extensao="*.gz'"
organiza
