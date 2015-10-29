#define isupper(c) { (c >= 'A' && c <= 'Z') ? 1 : 0; }

int isupper(int c)
{
    if (c >= 'A' && c <= 'Z')
        return 1;
    else
        return 0;
}
