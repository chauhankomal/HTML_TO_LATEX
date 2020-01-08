%option noyywrap


%{ 


#include<iostream>
#include<string>
#include<cstring>
#include "as.tab.h"
#include "AST.h"
using namespace std;


 

%} 


%x  A
%x FONTS
%x IMAGES
%x COMMENT
%x TABLE


SPECIAL [\"\.,\-=+!\(\)?\*:;@\'/] 
SPECIAL_SYMBOL [\^#\{\}_$\\\\%&/~/]
SPECIAL_COMMENT [\"\.,\^\=+#!\(\)?\*:;@\'/\{\}><&_$~%\\\\]
INT_STR1 \"([a-zA-Z0-9 \.,\^\=+#!\(\)?\*:;@/\{\}><&_$~%\\\\]*)\"
INT_STR2 \'([a-zA-Z0-9 \.,\^\=+#!\(\)?\*:;@/\{\}><&_$~%\\\\]*)\'



%%    

<*>\n ;

<*>[ \t]* ;

<A,FONTS,IMAGES,TABLE>\>	{
				BEGIN(INITIAL);
				return E_ANG_BRACKET;
				}



"<!DOCTYPE"(.*)">"  		;
					

"<!--"		  		   		{BEGIN(COMMENT);}

<COMMENT>"-->"				{BEGIN(INITIAL);}


"<html>"|"<HTML>"     		{return S_HTML;}

"</html>"|"</HTML>"	    	{return E_HTML;}

"<head>"|"<HEAD>"         	{return S_HEAD;}
						

"<body>"|"<BODY>"          	{return S_BODY;}

"<title>"|"<TITLE>"         	{return S_TITLE;}

"</title>"|"</title>"        	{return E_TITLE;}

"<h1>"|"<H1>"	  		{ return S_H1;}

"</h1>"|"</H1>"  	   		{return E_H1;}

<FONTS,A,INITIAL>"<font"|"<FONT"   	{BEGIN(FONTS); 
				return FONT; }


<FONTS>"size"|"SIZE"       	{return SIZE;
			}

<A>"name"|"NAME"      		{return NAME;
			}

"</font>"|"</FONT>"    	       {return E_FONT;}

<FONTS,IMAGES,A,TABLE>{INT_STR1}|{INT_STR2} {  char *temp = strdup(yytext);
						temp[strlen(temp)-1]='\0';
						temp++;						
						yylval.s = temp;
						return ATTR_VAL;}


<A>"title"|"TITLE"              {return TITLE;}
"<a"|"<A"       		{ BEGIN(A);
			return A_HREF;}

"</a>"|"</A>"      		{ return E_A;}

"<h2>"|"<H2>"      		{ return S_H2;}

"</h2>"|"</H2>"     		{return E_H2;}

"<h3>"|"<H3>"   	   	{return S_H3;}

"</h3>"|"/H3"         		{return E_H3;}

"<u>"|"<U>"   	   		{return S_U;}

"</u>"|"</U>"         		{return E_U;}

"<h4>"|"<H4>"          		{return S_H4;}

"</h4>"|"</H4>"         	{return E_H4;}

"<tr>"|"<TR>"      		{return S_TR;}

"</tr>"|"</TR>"     		{return E_TR;}

"<th>"|"<TH>"   	     	{return S_TH;}

"</th>"|"</TH>"            	{ return E_TH; }

"<td>"|"<TD>"             	{return S_TD; }

"</td>"|"</TD>"          	{return E_TD; }

"<caption>"|"CAPTION"         	{return S_CAPTION; }

"</caption>"|"</CAPTION>"        	{return E_CAPTION; }

"<center>"|"<CENTER>"         	{return S_CENTER; }

"</center>"|"</CENTER>"        	{return E_CENTER; }

"<br/>"|"<br>"|"<BR/>"|"<BR>"             	{
				return BREAK; }

"<p>"|"<P>" 			  	{return S_PARA; }

"</p>"|"</P>" 			  	{return E_PARA; }

"<ol>"|"<OL>" 				{return S_OLIST; }

"</ol>"|"</OL>" 				{return E_OLIST; }

"<ul>"|"<UL>" 				{return S_ULIST; }

"</ul>"|"</UL>" 			{return E_ULIST; }

"<li>"|"<LI>" 				{return S_ITEM; }

"</li>"|"</LI>" 				{return E_ITEM; }

"<dl>"|"<DL>" 				{return S_DL; }

"</dl>"|"</DL>" 				{return E_DL; }

"<dt>"|"<DT>" 				{return S_DT; }

"</dt>"|"</DT>" 				{return E_DT; }

"<sub>"|"<SUB>" 				{return S_SUB; }

"</sub>"|"</SUB>" 			{return E_SUB; }

"<sup>"|"<SUP>" 			{return S_SUP; }

"</sup>"|"</SUP>" 			{return E_SUP; }

"<dd>"|"<DD>" 				{return S_DD; }

"</dd>"|"</DD>" 			{return E_DD; }

"<i>"|"<I>"             		{return S_I; }
"</i>"|"</I>"       			{return E_I; }

"<small>"|"<SMALL>"     			{return S_SMALL; }
"</small>"|"</SMALL>"    			{return E_SMALL; }

"<strong>"|"<STRONG>"   			{return S_STRONG; }
"</strong>"|"</STRONG>"  			{return E_STRONG; }

"<b>"|"<B>"   		    	{return S_BOLD; }
"</b>"|"</B>" 			   	{return E_BOLD; }

"<em>"|"<EM>"  			{return S_EM; }
"</em>"|"</EM>" 				{return E_EM; }

"<figure>"|"<FIGURE>"  			{return S_FIG; }
"</figure>"|"</FIGURE>" 			{return E_FIG; }

"<figcaption>"|"<FIGCAPTION>"   		{return S_FIGCAPTION; }
"</figcaption>"|"</FIGCAPTION>" 			{return E_FIGCAPTION; }

"<tt>"|"<TT>"    			{return S_TT; }
"</tt>"|"</TT>" 				{ return E_TT; }

"<div>"|"<DIV>"    			{return S_DIV; }
"</div>"|"</DIV>" 			{return E_DIV; }


"</table>"|"</TABLE>" 			 {return E_TABLE; }


"<img"|"<IMG" 				{ BEGIN(IMAGES);
				return IMAGE_WITH_ATTRIBUTE;  }

<IMAGES>"src"|"SRC"   			{ return SOURCE; 
					}

<IMAGES>"width"|"WIDTH"   		{return WIDTH ; }

<IMAGES>"height"|"HEIGHT"   		{return HEIGHT; }

<A>"href"|"HREF"    			{ return HREF;}

<FONTS,IMAGES,A,TABLE>=   	;

"<table"|"<TABLE" 			{BEGIN(TABLE);
				      return S_TABLE ; }

<TABLE>"border"|"BORDER"  		{return BORDER ; }


"</body>"|"</BODY>"   			{return E_BODY; }

"</head>"|"</HEAD>"  			{return E_HEAD;}



<COMMENT>([a-zA-Z0-9 ]|{SPECIAL_COMMENT})*   ; 


"&"([a-zA-Z]+)";"   	{char *temp = strdup(yytext);
			temp[strlen(temp)-1]='\0';
			temp++;	
			string str = map_greek$(string(temp));				
			char cstr[str.size() + 1];
	                strcpy(cstr, str.c_str());
			yylval.s = cstr;
			return STRING;}


{SPECIAL_SYMBOL}               	{ char *temp= strdup(yytext);
				string str = map_symbol$(string(temp));
								
				char cstr[str.size() + 1];
	                	strcpy(cstr, str.c_str());
				yylval.s = strdup(cstr);
				//cout<<cstr<<"SYMBOL"<<endl;
				return STRING;
				}

([a-zA-Z0-9 ]|{SPECIAL})*   	{
				yylval.s = strdup(yytext);
				return STRING; }

<*>. ;

%%






/*
int main(int argc, char* argv[])
{
	if(argc > 1)
	{
		FILE *fp = fopen(argv[1], "r");

		if(fp)
			yyin = fp;
	}
	do {
		yylex();
	} while (!feof(yyin));
	return 1;}
*/

	
