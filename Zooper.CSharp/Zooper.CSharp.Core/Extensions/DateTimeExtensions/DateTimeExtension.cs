using System;

namespace Zooper.CSharp.Core.Extensions.DateTimeExtensions
{
	public static class DateTimeExtension
	{
		/// <summary>
		/// Calculates if the passed DateTime is the nth (Mon-, Tues-, ...) Day within this Month
		/// </summary>
		/// <param name="curDate"></param>
		/// <param name="occurrence"></param>
		/// <param name="day"></param>
		/// <returns></returns>
		public static DateTime NthOf(this DateTime curDate, int occurrence, DayOfWeek day)
		{
			var fday = new DateTime(curDate.Year, curDate.Month, 1);

			var fOc = fday.DayOfWeek == day ? fday : fday.AddDays(day - fday.DayOfWeek);
			// CurDate = 2011.10.1 Occurance = 1, Day = Friday >> 2011.09.30 FIX. 
			if (fOc.Month < curDate.Month) occurrence = occurrence + 1;
			return fOc.AddDays(7 * (occurrence - 1));
		}

		public static DateTime LastDayOfWeekInMonth(this DateTime curDate, DayOfWeek day)
		{
			var lastDay = new DateTime(curDate.Year, curDate.Month, 1).AddMonths(1).AddDays(-1);
			var lastDow = lastDay.DayOfWeek;

			var diff = day - lastDow;

			if (diff > 0) diff -= 7;

			System.Diagnostics.Debug.Assert(diff <= 0);

			return lastDay.AddDays(diff);
		}

		/// <summary>
		/// Checks if a given DateTime is within a range
		/// </summary>
		/// <param name="dateTime"></param>
		/// <param name="startDate"></param>
		/// <param name="duration"></param>
		/// <returns></returns>
		public static bool IsInRange(this DateTime dateTime, DateTime startDate, TimeSpan duration)
		{
			var endDate = startDate.Add(duration);

			return dateTime >= startDate && dateTime < endDate;
		}
	}
}
