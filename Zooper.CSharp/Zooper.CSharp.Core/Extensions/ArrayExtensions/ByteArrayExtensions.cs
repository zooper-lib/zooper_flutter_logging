namespace Zooper.CSharp.Core.Extensions.ArrayExtensions
{
	public static class ByteArrayExtensions
	{
		/// <summary>
		/// <para>Converts the first 3 bytes, beginning at <see cref="index"/>, to a Int24</para>
		/// <para>Note: Int24 is no general data type, so the returning int has still 4 bytes</para>
		/// </summary>
		/// <param name="bytes">The bytes as input</param>
		/// <param name="index">The position where to start</param>
		/// <returns>A 4-byte Int24</returns>
		public static int ToInt24(this byte[] bytes, int index = 0)
		{
			var num = bytes[index] + (bytes[index + 1] << 8) + (bytes[index + 2] << 16);
			return num;
		}
	}
}
