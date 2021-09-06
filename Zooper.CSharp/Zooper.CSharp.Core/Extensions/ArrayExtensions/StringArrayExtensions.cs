using Zooper.CSharp.Core.Extensions.StringExtensions;

namespace Zooper.CSharp.Core.Extensions.ArrayExtensions
{
    public static class StringArrayExtensions
	{
		public static bool ContainsInPercent(this string[] source, string target, double minPercentage, bool ignoreCase)
		{
			for (int i = 0; i < source.Length; i++)
			{
				if (source[i].IsEqualsInPercent(target, minPercentage, ignoreCase))
				{
					return true;
				}
			}

			return false;
		}
	}
}
