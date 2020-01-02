#include<iostream>
#include<vector>
#include<string>
#include<cstring>
#include<fstream>
#include<sstream>
#include<stack>
#include<map>
#include "MAP.h"

using namespace std;

map<string, string> greek;
map<string , string> symbol;
string mapping[50];

void mapper(){

mapping[T_H1]="\n\\section*{{\\huge ";
mapping[T_H2] = "\n\\section*{";
mapping[T_H3] = "\n\\subsection*{";
mapping[T_U] = "\n\\underline{";
mapping[T_H4] = "\n\\subsubsection*{";
mapping[T_PARA] = "\n\\par ";
mapping[T_DIV] = "\n\\par ";
mapping[T_SMALL] = " {\\small ";
mapping[T_BOLD] = " \\textbf{";
mapping[T_EM] = " \\emph{";
mapping[T_TT] = " \\texttt{";
mapping[T_I] = " \\textit{";
mapping[T_CENTER] = "\n\\begin{center}";
mapping[T_STRONG] = "\n\\textbf{";
mapping[T_ITEM] = "\n\\item ";
mapping[T_OLIST] = "\n\\begin{enumerate}";
mapping[T_ULIST] = "\n\\begin{itemize}";
mapping[T_DITEM] = "\n\\item";
mapping[T_DT] = "[";
mapping[T_DL] = "\n\\begin{description}";
mapping[T_DD] = " ";
mapping[T_TCAP] = "\n\\caption{";
mapping[T_TABLE] = "\n\\begin{tabular}";
mapping[T_IMG] = "\n\\includegraphics[";
mapping[T_FIG] = "\n\\begin{figure}[h!]";
mapping[T_FIGCAP]= "\n\\caption{";
mapping[T_A]= "\n\\href{";
mapping[T_SUB]= " $ _{";
mapping[T_SUP]= " $ ^{";
mapping[T_TITLE]="\\title{\\vspace{-2cm}";

}

void map_greek(){
	greek.insert({"Alpha", " A "});
	greek.insert({"Beta"," B "});
	greek.insert({"Gamma"," $ \\Gamma $ "});
	greek.insert({"Delta"," $ \\Delta $ "});
	greek.insert({"Epsilon"," E "});
	greek.insert({"Zeta"," Z "});
	greek.insert({"Eta"," H "});
	greek.insert({"Theta"," $ \\Theta $ "});
	greek.insert({"Iota"," I "});
	greek.insert({"Kappa"," K "});
	greek.insert({"Lambda"," $ \\Lambda $ "});
	greek.insert({"Mu"," M "});
	greek.insert({"Nu"," N "});
	greek.insert({"Xi"," $ \\Xi  $"});
	greek.insert({"Omricon"," O "});
	greek.insert({"Pi"," $ \\Pi $"});
	greek.insert({"Rho"," P "});
	greek.insert({"sigma"," $ \\Sigma $"});
	greek.insert({"tau"," T "});
	greek.insert({"Upsilon"," $ \\Upsilon $"});
	greek.insert({"Phi"," $ \\Phi $"});
	greek.insert({"Chi"," X "});
	greek.insert({"Psi"," $ \\Psi $"});
	greek.insert({"Omega"," $ \\Omega $"});

}

void map_symbol(){
symbol.insert({"#","\\# "});
symbol.insert({"$","\\$ "});
symbol.insert({"%","\\% "});
symbol.insert({"_","\\_ "});
symbol.insert({"^","\\^{} "});
symbol.insert({"~","\\~{} "});
symbol.insert({"&","\\& "});
symbol.insert({"{","\\{ "});
symbol.insert({"}","\\} "});
symbol.insert({"\\","\\textbackslash "});
symbol.insert({"/","/ "});
}


