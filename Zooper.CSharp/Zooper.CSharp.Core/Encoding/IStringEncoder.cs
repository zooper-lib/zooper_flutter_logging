namespace Zooper.CSharp.Core.Encoding
{
    public interface IStringEncoder
    {
        byte[] Encode(string input);

        string Decode(byte[] bytes, int index, int length);
    }
}
