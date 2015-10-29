struct tnode {
    char *word;
    int count;
    struct tnode *left;
    struct tnode *right;
};

struct list {
    char *head;
    struct tnode *root;
    struct list *left;
    struct list *right;
};

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAXWORD 100
struct list *addlist(struct list *, int, char *);
void allprint(struct list *);
struct tnode *addtree(struct tnode *, char *);
void treeprint(struct tnode *);
int getword(char *, int);

int main(int argc, char *argv[])
{
    struct list *root;
    char word[MAXWORD];
    int n;

    n = 6;
    if (argc >= 2) {
        n = atoi(argv[1]);
    }

    root = NULL;
    while (getword(word, MAXWORD) != EOF)
        if (isalpha(word[0]))
            root = addlist(root, n, word);
    allprint(root);

    return 0;
}

struct tnode *talloc(void);
char *strdup2(char *s);

struct list *addlist(struct list *p, int n, char *s)
{
    int cond;

    if (p == NULL) {
        p = (struct list*)malloc(sizeof(struct list));
        p->head = (char *)malloc(n);
        p->root = NULL;
        p->left = p->right = NULL;
        strncpy(p->head, s, n);
        p->root = addtree(p->root, s);
    } else if ((cond = strncmp(p->head, s, n)) == 0) {
        p->root = addtree(p->root, s);
    } else if (cond < 0) {
        p->left = addlist(p->left, n, s);
    } else {
        p->right = addlist(p->right, n, s);
    }
    return p;
}

void allprint(struct list *p)
{
    if (p != NULL) {
        allprint(p->right);
        printf("*** %s ***\n", p->head);
        treeprint(p->root);
        allprint(p->left);
    }
}

struct tnode *addtree(struct tnode *p, char *w)
{
    int cond;

    if (p == NULL) {
        p = talloc();
        p->word = strdup(w);
        p->count = 1;
        p->left = p->right = NULL;
    } else if ((cond = strcmp(w, p->word)) == 0)
        p->count++;
    else if (cond < 0)
        p->left = addtree(p->left, w);
    else
        p->right = addtree(p->right, w);
    return p;
}

void treeprint(struct tnode *p)
{
    if (p != NULL) {
        treeprint(p->left);
        printf("%4d %s\n", p->count, p->word);
        treeprint(p->right);
    }
}

#include <stdlib.h>

struct tnode *talloc(void)
{
    return (struct tnode *) malloc(sizeof(struct tnode));
}

char *strdup2(char *s)
{
    char *p;

    p = (char *) malloc(strlen(s)+1);
    if (p != NULL)
        strcpy(p, s);
    return p;
}


/**********************************************************************/

int getword(char *word, int lim)
{
    int c, getch(void);
    void ungetch(int);
    char *w = word;

first:
    while (isspace(c = getch()))
        ;
    if (c == '"') {
        while ((c = getch()) != '"')
            ;
        if (isspace(c)) {
            ungetch(c);
            goto first;
        }
    }
    if (c == '/') {
        if ((c = getch()) == '*') {
            while (1) {
                if ((c = getch()) != '*') continue;
                if ((c = getch()) == '/') break;
            }
            if (isspace(c = getch())) {
                ungetch(c);
                goto first;
            }
        } else {
            ungetch(c);
            c = '/';
        }
    }

    if (c != EOF)
        *w++ = c;
    if (!isalpha(c)) {
        *w = '\0';
        return c;
    }
    for ( ; --lim > 0; w++)
        if (!isalnum(*w = getch())) {
            ungetch(*w);
            break;
        }
    *w = '\0';
    return word[0];
}

#include <stdio.h>

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
