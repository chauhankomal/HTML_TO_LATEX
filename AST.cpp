#include<iostream>
#include<vector>
#include<string>
#include<cstring>
#include<fstream>
#include<sstream>
#include<stack>
#include<map>
#include"MAP.h"

using namespace std;


extern int count;
int table_col;
int border=0 ;
string width="";
string height="";
string href="";
string source="";
string caption;

extern vector<astNode*> *content_child;
extern vector<astNode*> *tag_child;
extern string mapping[50];
extern vector<astNode*> *attr_child;
extern map<string, string> greek;
extern map<string, string> symbol;
extern stack<vector<astNode*> > tag_child_stack;
string font_size[]={"","scriptsize","small","normalsize","Large","LARGE","huge","Huge"};





string map_greek$(string str){
	string temp="";
	if(str[0]>= 'a' && str[0]<='z')
		temp = " $ \\" + str + " $ ";
	else 	
	 temp = greek.at(str);
	
	return temp;
}

string map_symbol$(string str){
	 string temp = "";
	temp = symbol.at(str);
	
	return temp;
}
astNode* new_node(){
	astNode* temp = new astNode;
	return temp;
}


void init_tag_child(){
	tag_child = new vector<astNode*>();
}



void make_new_tag(){
if(count!=1){
	
  tag_child_stack.push(*tag_child);
  init_tag_child();
}
}
void init_attr_child(){
	attr_child = new vector<astNode*>();
}

void adopt_child(astNode *current){

	current->childs = *tag_child;
	if(!tag_child_stack.empty()){
		*tag_child= tag_child_stack.top();
		tag_child_stack.pop();
	}

}


string get_col(){
	string t = "{";
	if(border) t+="|";
	for(int i =0; i<table_col; i++){
		t+= "l";
		if(border) t += "|";
	}
	t += "}";
	return t;
}

string insert$(string str){
	string left, right;
	int i =0;
	for(i = str.size()-1; i>0 ; i--)
		if(str[i]==' ')
            		break;
		
	left=str.substr(0, i);
	right= str.substr(i+1, str.size()-i-1);
	left = left + " $ " + right;	
	
return left;		
}


string traverse_children (vector<astNode*> child_vector){
	string temp="";
	if(!child_vector.empty())
   	for(int i= 0; i< child_vector.size(); i++){
		temp += traversal(child_vector[i]);
         
	}
	return temp;

}

string traverse_table_row(vector<astNode*> child_vector){

	string temp ="";
  	 if(!child_vector.empty()) {
		temp += traversal(child_vector[0]);
   		for(int i= 1; i< child_vector.size(); i++){
		temp += " & ";
		temp += traversal(child_vector[i]);
		}

  	 }
	temp +="\\\\ \n";
	if(border)  temp += "\\hline ";
	return temp;
}

string traversal (astNode *root ){
	int type = root -> node_type;
	int size;
	string temp ="";   
	switch(type) {
	
	case STR:
		temp += root->str_data;
		break;
	 	
	case T_CONTENT:
		temp += traverse_children(root->childs);
		break;

	case T_FONT:
		size = std::stoi(root->str_data);
		if(size <1) size =1;
		else if (size>7) size =7;

		temp += "{\\" + font_size[size] + " ";
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "}";
		break;

	case T_DL:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n\\end{description}";	
		break;
	case T_FIG:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n\\end{figure}";	
		break;

	case T_DT:
		temp =  mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "]";	
		break;
	case T_TCAP :
		caption += "\n\\caption{";
		caption += traverse_children(root->childs);
		caption += "}";
		break;
	case T_TITLE:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp +="}\n\\date{}\n\\maketitle ";
		break;
		
	case T_DIV :	
	case T_PARA :
	case T_ITEM :
	case T_DITEM :
	case T_DD :
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		break;
	case T_H1 :
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp +="}}";
		break;
	case T_ATITLE:
		break;
	case T_H2 :
	case T_H3 :
	case T_H4 :
	case T_SMALL :
	case T_STRONG :
	case T_BOLD :
	case T_EM :
	case T_TT :
	case T_I :
	case T_FIGCAP :
	case T_U:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp +="}";
		break;
	case T_BORDER:
		border = stoi(root->str_data);
		break;
	case T_WIDTH:
		width += "width = ";
		width += root->str_data;
		width += "px";
		root->str_data = width;
		break;
	case T_HEIGHT:
		height += "height = ";
		height += root->str_data;
		height += "px";
		root->str_data= height;
		break;
	case T_SOURCE:
		source = string(root->str_data);
		break;
	case T_NAME:
		temp +="\n\\label{";
		temp += string(root->str_data);
		temp +=	"}\n";
		
		break;
	case T_HREF:
		href="";
		href += string(root->str_data);
		break;

	case T_TROW :
		table_col =0;
		temp= "\n";
		temp = traverse_table_row(root->childs);
		break;

	case T_THEAD:
		temp += mapping[T_BOLD];
		temp += traverse_children(root->childs);
		temp +="}";
		break;
		
	case T_TDATA: 
		table_col++;
		temp += traverse_children(root->childs);
		break;
		
	case T_IMG:
		width ="";
		height ="";
		source ="";
		traverse_children(root->attr);
		temp += mapping[type];
		temp += width;
		temp +=",";
		temp += height;
		temp +="]{";
		temp += source;
		temp += "}";
		root->str_data= temp;
		
		break;
	case T_A:
		temp +=traverse_children(root->attr);
		temp += mapping[type];
		temp = temp +  href+ "}{";
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "}\n";
		
		break;
	case T_CENTER :
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n\\end{center}";	
		break;	

	case T_OLIST:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n\\end{enumerate}";	
		break;	
	case T_SUB:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n} $ ";	
		break;	
	case T_SUP:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n} $ ";	
		break;		

	case T_ULIST:
		temp = mapping[type];
		root->str_data= temp;
		temp += traverse_children(root->childs);
		temp += "\n\\end{itemize}";
		break;
	
	case T_TABLE : 
		caption="";
		traverse_children(root->attr);
		temp = "\n\\begin{table}[h!]";
		temp += mapping[type];
		string s1 = traverse_children(root->childs);
		temp += get_col();
		if(border) temp += "\\hline\n";
		root->str_data= temp;
		temp += s1;
		temp += "\n\\end{tabular}";
		temp += caption;
		temp += "\n\\end{table}";
		break;
	
	
	}

return temp;
}



void printLatex(string s , char* file ){
  ofstream myfile;
  myfile.open (file);
  string temp ="\\documentclass{article}\n\\usepackage{graphicx}\n\\usepackage{hyperref}\n\\setlength\\parindent{0pt}\n\\begin{document}\n";
  myfile<<temp;
  myfile <<s<<"\n";
  myfile<<"\\end{document}\n";
  myfile.close();	

}

