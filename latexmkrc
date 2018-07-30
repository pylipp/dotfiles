# From https://tex.stackexchange.com/questions/58963/latexmk-with-makeglossaries-and-auxdir-and-outdir#59098
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
  my ($base_name, $path) = fileparse($_[0]);
  pushd $path;
  my $return = system "makeglossaries $base_name";
  popd;
  return $return;
}

$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -shell-escape %O %S';

# .bbl files assumed to be regeneratable, safe as long as the .bib file is available
$bibtex_use = 2;

# User biber instead of bibtex
$biber = 'biber --debug %O %S';

# Default pdf viewer
$pdf_previewer = 'zathura %O %S';

# Use these two configs instead of the flags -pdf and -pvc
$pdf_mode = 1;
$preview_continuous_mode = 1;

$out_dir = 'build';

# -verbose option
$silent = 0;

# Indicate compilation status in window title. Requires xdotool installed.
$compiling_cmd = "xdotool search --name \"%D\" set_window --name \"%D compiling\"";
$success_cmd   = "xdotool search --name \"%D\" set_window --name \"%D OK\"";
$failure_cmd   = "xdotool search --name \"%D\" set_window --name \"%D FAILURE\"";
