#!/usr/bin/env raku

=begin comment
Organiza a pasta /home/usr/Downloads/ de acordo com os documentos
existentes, os colocando em pastas de acordo com suas extensões
=end comment

my $pathDownload = $*HOME.IO.add('Downloads').IO;
my $ImgsFolder   = $pathDownload.add("Imagens").IO;
my $PckgFolder   = $pathDownload.add("Pacotes").IO;
my $DocsFolder   = $pathDownload.add("Documentos").IO;

sub retornaExtens (Str:D $entrada) {
#retorna a extensão de um elemento de string caso ele seja um
#arquivo passível de extensibilidade, retornando False quando 
#o arquivo não possui qualquer sinal de ter uma extensão
	my $formatoImgs  = <.jpeg .jpg .png>;
	my $formatoDocs  = <.pdf .docx .doc .txt .odf .odt .ods .odg>;
	my $formatoPack  = <.exe .sh .AppImage .iso>;
	CATCH { return False; }

	my $interstr = $entrada.flip;
	$interstr   = $interstr.substr(0, $interstr.index('.')) ~ '.';
	return $interstr.flip;
}

sub subMoveArquivo(IO:D $entrada, IO:D $nome, IO:D $Folder) {
#caso a extensão de um arquivo exista em uma lista, dependendo 
#da lista à qual ela pertence, o arquivo é movido para uma pasta
#referente a um grupo de formatos. Caso a pasta não exista ainda
#ela será criada
	if $Folder.e==False { mkdir $Folder.IO };
	$entrada.move: $Folder.add($nome);
	put Q:s /[...] $nome movido para $Folder.../;
	return True;
}

sub moveArquivo (IO:D $entrada) {
#generaliza a função subMoveArquivo( ... ) para que os arquivos
#sejam enviados para suas respectivas pastas
	my $extens = retornaExtens($entrada.Str);
	my $nome = $entrada.basename.IO;
	given $extens {
		when $extens (elem) $formatoImgs.List { subMoveArquivo($entrada, $nome, $ImgsFolder) }
		when $extens (elem) $formatoDocs.List { subMoveArquivo($entrada, $nome, $DocsFolder) }
		when $extens (elem) $formatoPack.List { subMoveArquivo($entrada, $nome, $PckgFolder) }
		default { return False }
	}
}

sub removeFolder ( IO:D $Folder ) {
#caso uma pasta exista, mas sua lista de elementos esteja vazia
#ela é apagada para ser recriada novamente apenas quando for usada
	if ( $Folder.e && dir($Folder).elems==0 ) { 
		put Q :c /{$Folder.basename} está vazio e será removido.../;
		rmdir $Folder;
		}
}

sub MAIN {

	my $listaDownload = dir($pathDownload);
	removeFolder($ImgsFolder);
	removeFolder($DocsFolder);
	removeFolder($PckgFolder);

	loop (my $clk = 0; $clk < $listaDownload.elems; $clk++) {
		if $listaDownload[$clk].d { next; }
		else	{
			my $retorno = moveArquivo($listaDownload[$clk]);
			put Q :c /[???] Não foi possível mover {$listaDownload[$clk]}\n/ if $retorno==False;
		}
	}
}












