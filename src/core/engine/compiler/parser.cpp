#include "parser.h"
#include "../../debug.h"

Parser::Parser(Lexer &lex): lexer(&lex)
{
    ast = new Ast();
}

Parser::~Parser()
{
    delete ast;
}

Ast *Parser::parse()
{
    lexer->nextToken();
    while (lexer->token != Token::EOT) {
        std::cout << "Token: " << lexer->value << std::endl;
        lexer->nextToken();
    }

    return ast;
}
