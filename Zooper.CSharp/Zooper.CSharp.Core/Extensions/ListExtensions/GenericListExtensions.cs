using System;
using System.Collections.Generic;

namespace Zooper.CSharp.Core.Extensions.ListExtensions
{
    public static class GenericListExtensions
    {
        /// <summary>
        /// Clears the list and tells the garbage collector to collect the items
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list">The list to clear</param>
        public static void ClearAndFreeMemory<T>(this List<T> list)
        {
            list.Clear();
            var identifier = GC.GetGeneration(list);
            GC.Collect(identifier, GCCollectionMode.Forced);
        }
	}
}
