namespace Zooper.CSharp.Core.Encoding
{
    public class UnicodeEncoder : IStringEncoder
    {
        private readonly System.Text.Encoding _uniEncoder = System.Text.Encoding.Unicode;

        public byte[] Encode(string input)
        {
            return _uniEncoder.GetBytes(input);
        }

        public string Decode(byte[] bytes, int index, int length = 0)
        {
            return _uniEncoder.GetString(bytes);
        }
    }
}