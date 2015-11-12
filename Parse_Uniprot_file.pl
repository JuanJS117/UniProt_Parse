use warnings;
use strict;

my@datos=&Open_file;
&Parse_UniProt_file(@datos);

sub Open_file{#Subrutina para abrir un archivo.
	my$file=$ARGV[0];#El archivo es pasado como argumento del script a ejecutar en la línea de comandos.
	my@data=&Test_open_file($file);
	return @data;
}

sub Test_open_file{#Subrutina para comprobar que la apertura de un archivo ha sido realizada correctamente.
	my$file=$_[0];
	unless(open(INPUT,$file)){#Realmente la apertura es realizada en esta subrutina. En la subrutina "Open_file" simplemente se llama a la subrutina actual, y se extrae el contenido del archivo.
		print "Cannot open file $file. Try again.\n";
		exit;
	}
	my@data=<INPUT>;
	close INPUT;
	return @data;
}

sub Trim_blank_spaces{
  my$string=$_[0];
  $string=~s/\s+/ /g;
  return $string;
}

sub Parse_UniProt_file{
  my@data=@_;
  my$print_line;
  foreach my$line(@data){
    if ($line=~/^ID/){
      $print_line=substr($line,5,-1); #5 es la posición en la cadena del primer carácter de la línea.
      $print_line=&Trim_blank_spaces($print_line);
      print "El identificador de la secuencia es: $print_line";
    }#elsif ($line=~/^/)
  }
}
