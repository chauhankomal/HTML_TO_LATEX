%{
#define YYDEBUG 1
#include<iostream>
#include <cstdlib>
#include <cstdio>
#include<string>
#include<cstring>
#include<vector>	
#include<stack>
#include "AST.h"	

using namespace std;

typedef vector<astNode*> node_vec;

	extern int yylex();
	extern void yyerror(const char*);
	extern astNode* root;

	extern int yyparse();
	int count=0;
	vector<astNode*> *tag_child;
	vector<astNode*> *attr_child;
	stack<vector<astNode*> > tag_child_stack;
	char *str_text;

%}

%union {
	struct astNode *node;
	char* s;
	int i;
}

%start start

%type <node> content head title body tag tags font u_list o_list des_list image fig_caption figure anchor
%type <node>  list_item des_list_item table caption table_row attr_val attribute_type break
%type <s> text STRING ATTR_VAL GREEK SYMBOL



%token S_HEAD E_HEAD S_BODY E_BODY S_TITLE E_TITLE S_H1 E_H1 STRING FONT  S_HTML E_HTML
%token  S_H2 E_H2 S_H3 E_H3 S_H4 E_H4 A_HREF E_A  E_ANG_BRACKET S_U E_U TITLE
%token S_CENTER E_CENTER BREAK S_PARA E_PARA E_FONT WIDTH HEIGHT HREF S_FIGCAPTION E_FIGCAPTION
%token S_OLIST E_OLIST  S_ULIST E_ULIST S_ITEM E_ITEM S_DL E_DL S_DT E_DT S_DD E_DD
%token IMAGE_WITH_ATTRIBUTE S_I E_I S_SMALL E_SMALL S_STRONG E_STRONG 
%token S_BOLD E_BOLD S_EM E_EM S_TT E_TT S_DIV E_DIV E_TABLE S_TABLE SIZE ATTRIBUTE
%token SOURCE ATTR_VAL BORDER NAME ID S_SUB E_SUB S_SUP E_SUP SYMBOL
%token S_TD E_TD S_TR E_TR S_TH E_TH S_CAPTION E_CAPTION GREEK S_FIG E_FIG


%%

start : S_HTML content E_HTML 		{
					root= $2;
					};


content :  head body 			{
					$$ = new_node();
					$$->node_type=T_CONTENT;
					$$->childs.push_back($1);
					$$->childs.push_back($2);
					};


head :  S_HEAD  title E_HEAD  		{
					$$= $2;
					};


title : %empty                         	{}

	|mk S_TITLE tags E_TITLE 	{
					$$ = new_node();
					$$->node_type = T_TITLE;
					adopt_child($$);
					};


body : mk S_BODY body_content E_BODY	{
					$$  = new_node();
					$$->node_type = T_CONTENT;
					adopt_child($$);
					
					};



mk: %empty				{
					count++;
					make_new_tag();
					};


mka: %empty			        {
					init_attr_child();
					};

body_content  :  %empty 		{}

		|body_content tag	{
					tag_child->push_back($2);
					}
		;


tag :   mk S_PARA tags E_PARA 		{
					$$ = new_node();
					$$->node_type= T_PARA;
					adopt_child($$);	
					}


	|mk S_H1 tags E_H1		{
					$$ =new_node();
					$$->node_type = T_H1; 
					adopt_child($$);
					}

	

	|mk S_H2 tags E_H2		{
					$$ =new_node();
					$$->node_type = T_H2; 
					adopt_child($$);
					}

	|mk S_H3 tags E_H3		{
					$$ =new_node();
					$$->node_type = T_H3; 
					adopt_child($$);
					}

	|mk S_H4 tags E_H4		{
					$$ =new_node();
					$$->node_type = T_H4; 
					adopt_child($$);
					}

	|mk S_DIV tags E_DIV		{
					$$ =new_node();
					$$->node_type = T_DIV; 
					adopt_child($$);
					}

	|mk S_SMALL tags E_SMALL	{
					$$ =new_node();
					$$->node_type = T_SMALL; 
					adopt_child($$);
					}

	|mk S_STRONG tags E_STRONG	{
					$$ =new_node();
					$$->node_type = T_STRONG; 
					adopt_child($$);
					}
	

	|mk S_I tags E_I		{
					$$ =new_node();
					$$->node_type = T_I; 
					adopt_child($$);
					}

	|mk S_SUB tags E_SUB		{
					$$ =new_node();
					$$->node_type = T_SUB; 
					adopt_child($$);
					}

	|mk S_SUP tags E_SUP		{
					$$ =new_node();
					$$->node_type = T_SUP; 
					adopt_child($$);
					}


	|mk S_EM tags E_EM		{
					$$ =new_node();
					$$->node_type = T_EM; 
					adopt_child($$);
					}

	|mk S_U tags E_U		{
					$$ =new_node();
					$$->node_type = T_U; 
					adopt_child($$);
					}

	|mk S_TT tags E_TT		{
					$$ =new_node();
					$$->node_type = T_TT; 
					adopt_child($$);
					}

	|mk S_BOLD tags E_BOLD		{
					$$ =new_node();
					$$->node_type = T_BOLD; 
					adopt_child($$);
					}

	|mk S_CENTER tags E_CENTER	{
					$$ =new_node();
					$$->node_type = T_CENTER; 
					adopt_child($$);
					}

	|mk font			{
					$$ =$2;
					}

	|o_list				{
					$$ =$1;
					}

	|u_list				{
					$$ =$1;
					}

	|des_list    			{
					$$=$1;
					}
	
	|image    			{
					$$=$1;
					}

	|figure   			{
					$$=$1;
					}

	|anchor				{
					$$=$1;
					}

	|table              		{
					$$ =$1;
					}

	|text				{
					$$  =new_node();
					$$->node_type =STR; 
					string s = string($1);
					$$->str_data = s;
					}

	|break  			{
					$$=$1;
					}
;



break :	 BREAK     			{
					$$  =new_node();
		              		$$->node_type =STR; 
			    		$$->str_data = "\\hfill \\break ";
					}
;

tags : 	%empty       			{}
	|tags tag			{
					tag_child->push_back($2);
					}

	
	
;



font:  	FONT SIZE ATTR_VAL E_ANG_BRACKET  tags E_FONT  	{
							$$ =new_node();
							$$->node_type = T_FONT;
							$$->str_data =$3;
							adopt_child($$);
							}  
;

o_list: mk S_OLIST  list_con E_OLIST   			{
							$$ =new_node();
							$$->node_type =T_OLIST;
							adopt_child($$); 		
							}
	
;

u_list:	mk S_ULIST list_con E_ULIST 			{
							$$ =new_node();
							$$->node_type =T_ULIST; 
							adopt_child($$);		
							}
;

list_con :	%empty

	 	|list_con o_list 			{
							tag_child->push_back($2); 
							}
		
		|list_con u_list 			{
							tag_child->push_back($2); 
							}
		
		|list_con list_item  			{
							tag_child->push_back($2);
							}
;

list_item :	mk S_ITEM  tags E_ITEM 			{  
							$$ =new_node();
							$$->node_type =T_ITEM;
							adopt_child($$); 
							}
;

des_list:  mk S_DL des_list_con E_DL    		{   
							$$ =new_node();
							$$->node_type =T_DL;
							adopt_child($$);
							}

;

des_list_con : 	%empty

		| des_list_con des_list_item 		{
							tag_child->push_back($2);
							}
;
 

dt_node :          %empty      				 {
							astNode *temp  =new_node();
							temp->node_type =T_DT;
							adopt_child(temp); 
							tag_child->push_back(temp);	
							} ;

dd_node :          %empty       			{
							astNode *temp  =new_node();
							temp->node_type =T_DD;
							adopt_child(temp); 
							tag_child->push_back(temp);	
							} ;


des_list_item : mk mk S_DT tags E_DT dt_node mk  S_DD tags E_DD dd_node		{
										$$ =new_node();
									      	$$->node_type =T_DITEM;
									      	adopt_child($$);
										};




table : mk S_TABLE mka attributes E_ANG_BRACKET table_rows E_TABLE  		{
										$$ =new_node();
					 					$$->node_type =T_TABLE;
									      	$$->attr = *attr_child;
									      	adopt_child($$);
									      	}
;


caption : mk S_CAPTION tags E_CAPTION 	{
					$$ =new_node();
					$$->node_type =T_TCAP;
					adopt_child($$);
					}
;

table_rows: %empty
	|table_rows table_row 		{
					tag_child->push_back($2);
					}
	|table_rows caption 		{
					tag_child->push_back($2);
					}
;


table_row :mk  S_TR table_data E_TR 	{
					$$ =new_node();
					$$->node_type =T_TROW;
					adopt_child($$);
					}
;

table_data: %empty

	| table_data mk S_TH tags E_TH  {
					astNode *temp =new_node();
					temp->node_type =T_THEAD;
					adopt_child(temp);
					tag_child->push_back(temp);
					}


	| table_data mk S_TD tags E_TD  {
					astNode *temp =new_node();
					temp->node_type =T_TDATA;
					adopt_child(temp);
					tag_child->push_back(temp);
					}
;


figure : mk S_FIG fig_attr E_FIG 	{
					$$ =new_node();
					$$->node_type =T_FIG;
					adopt_child($$);
					}
;

fig_attr : 	%empty
		|fig_attr image     	{
					tag_child->push_back($2);
					}
		|fig_attr fig_caption   {
					tag_child->push_back($2);
					}
;

fig_caption : mk S_FIGCAPTION tags E_FIGCAPTION		{
							$$ =new_node();
							$$->node_type =T_FIGCAP;
							adopt_child($$);
							}
;



image: IMAGE_WITH_ATTRIBUTE mka attributes E_ANG_BRACKET{
							$$ =new_node();
					 		$$->node_type =T_IMG;
							$$->attr = *attr_child;
							}
;
 
anchor :     mk A_HREF mka attributes E_ANG_BRACKET tags E_A{
							$$ =new_node();
					 		$$->node_type =T_A;
							$$->attr = *attr_child;
							adopt_child($$);
							}


;
attributes :%empty

	| attributes attr_val  				{
							attr_child->push_back($2);
							}
	;



attr_val :attribute_type ATTR_VAL	{
					$$ =new_node();
					$$->node_type =$1->node_type;
					$$->str_data = $2;
					}

;
attribute_type :WIDTH                   {
					$$ =new_node();
					$$->node_type =T_WIDTH	;			
					}

		|HEIGHT   		{
					$$ =new_node();
					$$->node_type =T_HEIGHT;
					}
		|SOURCE			{
					$$ =new_node();
					$$->node_type =T_SOURCE;
					}
		|HREF			{
					$$ =new_node();
					$$->node_type =T_HREF;
					}
            	|NAME			{
					$$ =new_node();
					$$->node_type =T_NAME;
					}
		|BORDER			{
					$$ =new_node();
					$$->node_type =T_BORDER;
					}
		|TITLE			{
					$$ =new_node();
					$$->node_type =T_ATITLE;
					}

;


text : STRING        			{
					str_text = (char*)malloc(2000);
					strcpy(str_text,"");
					strcat(str_text, $1);
					$$=str_text;
					}

	| text STRING  			{
					strcat(str_text, $2);
					$$=str_text;
					}	
;	


		
%%










