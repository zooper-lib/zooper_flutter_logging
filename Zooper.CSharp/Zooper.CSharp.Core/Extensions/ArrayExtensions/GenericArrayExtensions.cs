using System;
using System.Collections.Generic;
using System.Linq;

namespace Zooper.CSharp.Core.Extensions.ArrayExtensions
{
    public static class GenericArrayExtensions
    {
        /// <summary>
        /// Gets a part of an array
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="data"></param>
        /// <param name="index"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        public static T[] SubArray<T>(this T[] data, int index, int length)
        {
            var result = new T[length];
            Array.Copy(data, index, result, 0, length);
            return result;
        }

        /// <summary>
        /// Appends the items of an array to a given one
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="targetArray">The array the others will be merged into</param>
        /// <param name="arrays">The arrays to merge</param>
        /// <returns>The merged array</returns>
        public static T[] Merge<T>(this T[] targetArray, params T[][] arrays)
        {
            targetArray ??= Array.Empty<T>();

            foreach (var sourceArray in arrays)
            {
                if (sourceArray is not {Length: > 0})  continue;
                
                Array.Resize(ref targetArray, targetArray.Length + sourceArray.Length);
                Array.Copy(sourceArray, 0, targetArray, targetArray.Length, sourceArray.Length);
            }

            return targetArray;
        }

        // TODO: Check if this has any benefits
        public static IEnumerable<T> Merge<T>(this IEnumerable<T> l, params IEnumerable<T>[] lists)
        {
            return l.Concat(lists.SelectMany(x => x));
        }
    }
}