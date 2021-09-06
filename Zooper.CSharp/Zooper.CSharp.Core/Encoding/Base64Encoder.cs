using System;

namespace Zooper.CSharp.Core.Encoding
{
    public class Base64Encoder : IStringEncoder
    {
        public byte[] Encode(string input)
        {
            return Convert.FromBase64String(input);
        }

        public string Decode(byte[] bytes, int index, int length)
        {
            return Convert.ToBase64String(bytes);
        }
    }
}
