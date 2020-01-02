#include<iostream>
#include<vector>

#include<string>

using namespace std;

enum AST_Node_Type{
T_H1,  T_H2,T_H3, T_H4, T_PARA,T_DIV, T_SMALL, T_STRONG, T_EM, T_TT, T_I,T_BOLD, T_CENTER,STR, T_FONT,T_ULIST, T_OLIST, T_ITEM,T_ATITLE,
T_DD, T_DT, T_DITEM, T_DL,T_TABLE, T_TCAP, T_WIDTH, T_HEIGHT, T_SOURCE, T_HREF, T_NAME, T_BORDER, T_TROW, T_THEAD, T_TDATA, T_IMG, T_FIG, T_FIGCAP, T_A, T_U, T_SUB, T_SUP, T_TITLE, T_CONTENT};
	
typedef struct astNode {
	AST_Node_Type node_type;
	string str_data;
	vector<astNode*> childs;
	vector<astNode*> attr;

}astNode;




string map_greek$(string);
string map_symbol$(string);
void init_attr_child();
void init_tag_child();
void adopt_child(astNode *current);
void printLatex(string s ,char *file );
astNode* new_node();
astNode* mkn(string);
void make_new_tag();
vector<astNode*> make_new_vector();
string traversal (astNode* );
string traverse_children(vector<astNode*> child_vector);
