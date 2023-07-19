#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>


int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    for (int i = 0; i < strlen(argv[1]); i++)
    {
        if (!isdigit(argv[1][i]))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
    }
        int k = atoi(argv[1]);

        string pt = get_string("plaintext: ");
        printf("ciphertext: ");

        for (int c = 0; c < strlen(pt); c++)
        {
            if (islower(pt[c]))
            {
                printf("%c", (pt[c] - 97 + k) % 26 + 97);
            }
            else if (isupper(pt[c]))
            {
                printf("%c", (pt[c] - 65 + k) % 26 + 65);
            }
            else
            {
                printf("%c", pt[c]);
            }

        }
        printf("\n");
    }

