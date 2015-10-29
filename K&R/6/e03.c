struct tnode {
    char *word;
    struct count *value;
    struct tnode *left;
    struct tnode *right;
};

struct count {
    int n;
    struct count *next;
};

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAXWORD 100
#define SKIP (sizeof skip_word / sizeof skip_word[0])

struct tnode *addtree(struct tnode *, char *, int);
struct count *addlist(struct count *, int);
void treeprint(struct tnode *);
void treeprint2(struct tnode *);
int getword(char *, int, int *);

int main()
{
    struct tnode *root;
    char word[MAXWORD];
    int line, i, skip;
    char *skip_word[] = {
        "and", "the"
    };

    root = NULL;
    while (getword(word, MAXWORD, &line) != EOF) {
        skip = 0;
        for (i = 0; i < SKIP; i++) {
            if (strcmp(word, skip_word[i]) == 0)
                skip = 1;
        }
        if (skip == 1) continue;
        if (isalpha(word[0]))
            root = addtree(root, word, line);
    }

    treeprint(root);
    printf("*************************************\n");
    treeprint2(root);

    return 0;
}

struct tnode *talloc(void);
char *strdup2(char *s);

struct tnode *addtree(struct tnode *p, char *w, int n)
{
    int cond;

    if (p == NULL) {
        p = talloc();
        p->word = strdup(w);
        p->value = NULL;
        p->value = addlist(p->value, n);
        p->left = p->right = NULL;
    } else if ((cond = strcmp(w, p->word)) == 0)
        p->value = addlist(p->value, n);
    else if (cond < 0)
        p->left = addtree(p->left, w, n);
    else
        p->right = addtree(p->right, w, n);
    return p;
}

struct count *addlist(struct count *p, int n)
{
    int cond;

    if (p == NULL) {
        p = (struct count *)malloc(sizeof(struct count));
        p->n = n;
        p->next = NULL;
    } else if (n == p->n)
        ;
    else
        p->next = addlist(p->next, n);
    return p;
}

void treeprint(struct tnode *p)
{
    if (p != NULL) {
        treeprint(p->left);
        printf("%s\n", p->word);
        treeprint(p->right);
    }
}

void treeprint2(struct tnode *p)
{
    struct count *c;
    if (p != NULL) {
        treeprint2(p->left);
        printf("%s --- ", p->word);
        for (c = p->value; c != NULL; c = c->next) {
            printf("%d ", c->n);
        }
        printf("\n");
        treeprint2(p->right);
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

int getword(char *word, int lim, int *line)
{
    static int count = 1;
    int c, getch(void);
    void ungetch(int);
    char *w = word;

    while (isspace(c = getch()))
        if (c == '\n')
            count++;

    if (c != EOF)
        *w++ = c;
    if (!isalpha(c)) {
        *w = '\0';
        *line = count;
        return c;
    }
    for ( ; --lim > 0; w++)
        if (!isalnum(*w = getch())) {
            ungetch(*w);
            break;
        }
    *w = '\0';
    *line = count;
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
