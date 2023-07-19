#include "helpers.h"
#include "math.h"

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width; y++)
        {
            float Red = image[x][y].rgbtRed;
            float Green = image[x][y].rgbtGreen;
            float Blue = image[x][y].rgbtBlue;

            int ave = round((Red + Green + Blue) / 3);
            image[x][y].rgbtRed = image[x][y].rgbtGreen = image[x][y].rgbtBlue = ave;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width; y++)
        {
            float SRed = image[x][y].rgbtRed;
            float SGreen = image[x][y].rgbtGreen;
            float SBlue = image[x][y].rgbtBlue;

            int sepiar = round(.393 * SRed + .769 * SGreen + .189 * SBlue);
            int sepiag = round(.349 * SRed + .686 * SGreen + .168 * SBlue);
            int sepiab = round(.272 * SRed + .534 * SGreen + .131 * SBlue);

            if (sepiar > 255)
            {
                sepiar = 255;
            }
            if (sepiag > 255)
            {
                sepiag = 255;
            }
            if (sepiab > 255)
            {
                sepiab = 255;
            }
            image[x][y].rgbtRed = sepiar;
            image[x][y].rgbtGreen = sepiag;
            image[x][y].rgbtBlue = sepiab;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width/2; y++)
        {
            RGBTRIPLE tv = image[x][y];
            image[x][y] = image[x][width - (y + 1)];
            image[x][width - (y + 1)] = tv;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE t[height][width];
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width; y++)
        {
            t[x][y] = image[x][y];

        }
    }
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width; y++)
        {
            int r, g, b;
            r = g = b = 0;
            float counter = 0.00;

            for (int z = -1; z < 2; z++)
            {
                for (int u = -1; u < 2; u++)
                {
                    int oz = x + z;
                    int ou = y + u;

                    if (oz < 0 || oz > (height -1) || ou < 0 || ou > (width - 1))
                    {
                        continue;
                    }
                    r += image[oz][ou].rgbtRed;
                    g += image[oz][ou].rgbtGreen;
                    b += image[oz][ou].rgbtBlue;

                    counter++;
                }
                t[x][y].rgbtRed = round(r/counter);
                t[x][y].rgbtGreen = round(g/counter);
                t[x][y].rgbtBlue = round(b/counter);
            }
        }
    }
    for (int x = 0; x < height; x++)
    {
        for (int y = 0; y < width; y++)
        {
            image[x][y].rgbtRed = t[x][y].rgbtRed;
            image[x][y].rgbtGreen = t[x][y].rgbtGreen;
            image[x][y].rgbtBlue = t[x][y].rgbtBlue;
        }
        }
    return;
}
