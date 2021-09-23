using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Zooper.CSharp.Core.Extensions.IEnumerableExtensions
{
	public static class EnumerableExtensions
	{
		public static void ClearAndFreeMemory<T>(this ObservableCollection<T> list)
		{
			list.Clear();
			var identifier = GC.GetGeneration(list);
			GC.Collect(identifier, GCCollectionMode.Forced);
		}
		
	}
}
