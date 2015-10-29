#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getch(void);
void ungetch(int);
int getword(char *, int);
/************************************/
struct nlist {
    struct nlist *next;
    char *name;
    char *defn;
};

#define HASHSIZE 101

static struct nlist *hashtab[HASHSIZE];

unsigned hash(char *s)
{
    unsigned hashval;

    for (hashval = 0; *s != '\0'; s++)
        hashval = *s + 31 * hashval;
    return hashval % HASHSIZE;
}

struct nlist *lookup(char *s)
{
    struct nlist *np;

    for (np = hashtab[hash(s)]; np != NULL; np = np->next)
        if (strcmp(s, np->name) == 0)
            return np;
    return NULL;
}

int undef(char *name)
{
    struct nlist *np;
    struct nlist *temp;
    unsigned hashval;

    for (temp = NULL, np = hashtab[hash(name)]; np != NULL; np = np->next) {
        if (strcmp(name, np->name) == 0)
            break;
        temp = np;
    }
    if ((np = lookup(name)) == NULL)
        return -1;

    if (np->next == NULL)
        temp->next = NULL;
    else
        temp->next = np->next;
    free((void *)np);

    return 0;
}

char *strdup2(char *);

struct nlist *install(char *name, char *defn)
{
    struct nlist *np;
    unsigned hashval;

    if ((np = lookup(name)) == NULL) {
        np = (struct nlist *) malloc(sizeof(*np));
        if (np == NULL || (np->name = strdup2(name)) == NULL)
            return NULL;
        hashval = hash(name);
        np->next = hashtab[hashval];
        hashtab[hashval] = np;
    } else {
        free((void *) np->defn);
    } if ((np->defn = strdup2(defn)) == NULL)
        return NULL;
    return np;
}
char *strdup2(char *s)
{
    char *p;

    p = (char *) malloc(strlen(s)+1);
    if (p != NULL)
        strcpy(p, s);
    return p;
}
/*******************************************/

#define MAXWORD 128


int main()
{
    int c;
    char words[MAXWORD];
    char name[MAXWORD];
    char defn[MAXWORD];
    struct nlist *np;

    while ((c = getword(words, MAXWORD)) != EOF) {
        if (strcmp(words, "#define") == 0) {
            getword(name, MAXWORD);
            getword(defn, MAXWORD);
            install(name, defn);
            printf("%s %s %s ", words, name, defn);
        } else if ((np = lookup(words)) != NULL) {
            printf("%s ", np->defn);
        } else {
            printf("%s ", words);
        }
    }

    return 0;
}

/*********************************************************/

int getword(char *wd, int lim)
{
    int c, temp;
    char *w = wd;

    while (isspace(c = getch()))
        if(c == '\n')
            puts("");
    if (c == '/') {
        temp = c;
        if ((c = getch()) == '*') {
            while (1) {
                if ((c = getch()) == '*')
                    if ((c = getch()) == '/')
                        break;
                    else
                        ungetch(c);
            }
            c = getch();
        } else {
            ungetch(c);
            c = temp;
        }
    }

    if (c != EOF)
        *w++ = c;
    if (!isalnum(c) && c != '_' && c != '\'' && c != '#' && c != '\\') {
        *w = '\0';
        return c;
    }
    for ( ; --lim > 0; w++)
        if (!isalnum(*w = getch()) && *w != '_' &&
            *w != '\'' && *w != '#' && *w != '\\') {
            ungetch(*w);
            break;
        }
    *w = '\0';
    return wd[0];
}

#define BUFSIZE 100

char buf[BUFSIZE];
int bufp = 0;

int getch(void)
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c)
{
    if (bufp >= BUFSIZE)
        printf("ungetch: too many charcters\n");
    else
        buf[bufp++] = c;
}
