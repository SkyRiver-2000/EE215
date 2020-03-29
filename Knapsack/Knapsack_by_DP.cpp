// KnapSack.cpp : 双约束0-1背包问题，动态规划解法

#include <iostream>
#include <string>
using namespace std;

int ans[17][96][87];
string taken[17][96][87];

int max(int x, int y, int z)
{
	if (x > y && x > z) return x;
	return (y > z) ? y : z;
}

int main()
{
	int i, j, k, temp, volume[17], weight[17], value[17];

	for (i = 1; i <= 16; ++i)
		cin >> volume[i] >> weight[i] >> value[i];

	for (i = 0; i < 17; ++i)
		for (j = 0; j < 96; ++j)
			for (k = 0; k < 87; ++k)
			{
				ans[i][j][k] = 0;
				taken[i][j][k] = "";
			}

	for (i = 1; i <= 16; ++i)
	{
		for (j = 1; j <= 95; ++j)
		{
			for (k = 1; k <= 86; ++k)
			{
				temp = max(ans[i][j - 1][k], ans[i][j][k - 1], ans[i - 1][j][k]);
				if (volume[i] <= j && weight[i] <= k && ans[i - 1][j - volume[i]][k - weight[i]] + value[i] > temp)
				{
					ans[i][j][k] = ans[i - 1][j - volume[i]][k - weight[i]] + value[i];
					taken[i][j][k] = taken[i - 1][j - volume[i]][k - weight[i]] + "1";
				}
				else
				{
					ans[i][j][k] = temp;
					if(ans[i][j - 1][k] > ans[i][j][k - 1] && ans[i][j - 1][k] > ans[i - 1][j][k])
						taken[i][j][k] = taken[i][j - 1][k];
					else if(ans[i][j][k - 1] > ans[i - 1][j][k])
						taken[i][j][k] = taken[i][j][k - 1];
					else taken[i][j][k] = taken[i - 1][j][k] + "0";
				}
			}
		}
	}

	cout << ans[16][95][86] << endl << taken[16][95][86];

	return 0;
}
