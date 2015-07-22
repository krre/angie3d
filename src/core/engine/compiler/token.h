#pragma once

#include <string>

enum class Symbol {
    UNDEFINED,
    IDENT,
    NUMBER,
    WORD,
    END,
    LB, // {
    RB // }
};

struct Token
{
    Symbol sym;
    std::string value;
};