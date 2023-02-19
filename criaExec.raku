#!/usr/bin/env perl6

#cria um arquivo de extensão .raku de acordo com o nome especificado pelo usuário
#na pasta em que o script estiver. Caso já exista um arquivo com tal nome e extensões
#válidas para rakulang, o script avisa o usuário e pára sua execução. Caso não exista,
#ele cria o arquivo de nome requerido

sub detectaEntrada (Str:D $entrada, Str:D $extensao) {
#Verifica se o nome fornecido pelo usuário já pertence a algum arquivo dentro do diretório
#caso exista, retorna False. Caso não exista, retorna True;
	my @arquivos = dir();                        #array com arquivos do diretório
	for @arquivos { $_ = $_.Str }                #array de arquivos em versão String
	my $any = $entrada, do {
		if    $extensao (elem) <raku perl6>     { '.raku' }
		elsif $extensao (elem) <shell sh bash>  { '.sh'   }
		elsif $extensao (elem) <python py>      { '.py'   }
	}
	return  ($any (elem) @arquivos) ?? True !! False;
}

sub criaArquivo (Str:D $entrada, Str:D $extensao) {
#Cria um arquivo .raku com o nome especificado pelo usuário em caso de não existência
#prévia, adiciona o ambiente de criação e transforma o arquivo em um executável
	put "Criando arquivo";
	my $arquivo = $entrada;
	
	if ($extensao (elem) <raku perl6>) {
		$arquivo = $arquivo ~ '.raku';
		spurt $arquivo, "#!/usr/bin/env perl6\n\n\n";
	}
	if ($extensao (elem) <sh bash shell>) {
		$arquivo = $arquivo ~ '.sh';
		spurt $arquivo, "#!/usr/bin/bash\n\n\n";
	}
	if ($extensao (elem) <python py>) {
		$arquivo = $arquivo ~ '.py';
		spurt $arquivo, "#!/usr/bin/env python3\n\n\n";
	}
	shell "chmod +x $arquivo";
	shell "vim $arquivo";
}

sub MAIN (*@ARGS) {
	my @extens = <perl6 raku shell sh bash python py>;
	if ( (@ARGS.elems==2) and !(@ARGS[1] (elem) @extens) ) { 
		put q :heredoc/END/;
		    [!!!] Combinação inválida de argumentos.
		    Terminando...
		    END
		}
	elsif ( (@ARGS.elems==2) and (@ARGS[1] (elem) @extens) ) {
		my $existente = detectaEntrada(@ARGS[0], @ARGS[1]);
		if $existente==True { 
			put q :s:heredoc/END/;
			[!!!] Arquivo já existente.
			Terminando... 
			END
			}
		else { criaArquivo(@ARGS[0], @ARGS[1]) };
	}
	else {
		put q :s:heredoc/END/;
		[!!!] Combinação de comandos inexistente.
		Terminando...
		END
	}
}
