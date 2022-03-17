#!/usr/bin/env perl6

#cria um arquivo de extensão .raku de acordo com o nome especificado pelo usuário
#na pasta em que o script estiver. Caso já exista um arquivo com tal nome e extensões
#válidas para rakulang, o script avisa o usuário e pára sua execução. Caso não exista,
#ele cria o arquivo de nome requerido

sub detectaEntrada (Str:D $entrada) {
#Verifica se o nome fornecido pelo usuário já pertence a algum arquivo dentro do diretório
#caso exista, retorna False. Caso não exista, retorna True;
	my @arquivos = dir();                        #array com arquivos do diretório
	for @arquivos { $_ = $_.Str }                #array de arquivos em versão String
	my @extens = $entrada <<~>> <.p6 .t6 .raku>; #array possíveis entradas existentes
	my $any = [|] |@extens;
	return  ($any (elem) @arquivos) ?? True !! False;
}

sub criaArquivo (Str:D $entrada) {
#Cria um arquivo .raku com o nome especificado pelo usuário em caso de não existência
#prévia, adiciona o ambiente de criação e transforma o arquivo em um executável
	put "Criando arquivo";
	my $arquivo = $entrada ~ '.raku';
	spurt $arquivo, "#!/usr/bin/env perl6\n\n\n";
	shell "chmod +x $arquivo";
	shell "vim $arquivo";
}

sub MAIN (*@ARGS) {
	if (@ARGS.elems != 1) { 
		put q :heredoc/END/;
		    [!!!] Quantidade inválida de argumentos.
		    Terminando...
		    END
		}
	else {
		my $existente = detectaEntrada(@ARGS[0]);
		if $existente==True { 
			put q :s:heredoc/END/;
			[!!!] Arquivo já existente.
			Terminando... 
			END
			}
		else { criaArquivo(@ARGS[0]) };
	}
}
