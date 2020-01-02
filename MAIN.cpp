#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include "MAP.h"

using namespace std;

extern int yyparse();
extern FILE *yyin;
astNode *root;


void yyerror(const char *s) {
	cout<<"Parse error!  Message:"<<s<<endl;
	// might as well halt now:
	exit(-1);
}


int main(int argc, char *argv[]) {
	mapper();
	map_greek();
	map_symbol();
	init_tag_child();
	init_attr_child();
	if(argc<3){
		cout<<"error in entering arguments. Correct Format: /compiler <input.txt>";
	}
	yyin = fopen(argv[1], "r");
	char* tex_file = argv[2];
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));

	
	string s = traversal(root);
	printLatex(s, tex_file);
	cout<<"-----"<<tex_file<<" created ----------"<<endl;
	//cout<<s<<"-------"<<endl;
	
}
