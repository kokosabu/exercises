#include <stdio.h>

#define MAXLEN 1024

void escape(char s[], char t[]);
void unescape(char s[], char t[]);

int main()
{
    char s[MAXLEN] = "\thoge\n\\hoge";
    char t[MAXLEN];

    printf("[%s]\n", s);
    escape(s, t);
    printf("[%s]\n", t);
    unescape(t, s);
    printf("[%s]\n", s);

    return 0;
}

void escape(char s[], char t[])
{
    int i, j;

    j = 0;
    for (i = 0; s[i] != '\0'; i++) {
        switch (s[i]) {
        case '\t':
            t[j++] = '\\';
            t[j++] = 't';
            break;
        case '\n':
            t[j++] = '\\';
            t[j++] = 'n';
            break;
        case '\\':
            t[j++] = '\\';
            t[j++] = '\\';
            break;
        default:
            t[j++] = s[i];
            break;
        }
    }
    t[j] = s[i];
}

void unescape(char s[], char t[])
{
    int i, j;
    int data;

    j = 0;
    for (i = 0; s[i] != '\0'; i++) {
        if (s[i] == '\\') {
            switch (s[i+1]) {
            case '0': case '1': case '2': case '3':
            case '4': case '5': case '6': case '7':
                data = s[i+1];
                data = data * 8 + s[i+2];
                data = data * 8 + s[i+3];
                t[j++] = data;
                i += 3;
                break;
            case 'x':
                data = s[i+2];
                data = data * 16 + s[i+3];
                t[j++] = data;
                i += 3;
                break;
            case 'n':
                t[j++] = '\n';
                i += 1;
                break;
            case 't':
                t[j++] = '\t';
                i += 1;
                break;
            case '\\':
                t[j++] = '\\';
                i += 1;
                break;
            }
        } else {
            t[j++] = s[i];
        }
    }
    t[j] = s[i];
}
