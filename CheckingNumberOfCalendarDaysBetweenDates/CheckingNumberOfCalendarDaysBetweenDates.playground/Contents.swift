import UIKit



func compareDates() {
    let twoDaysAgoDate = Date().addingTimeInterval(-172800)
    let slightlyUnder48HoursAgoDate = Date().addingTimeInterval(-168500)
    let yesterdayDate = Date().addingTimeInterval(-86400)

    let calendar = Calendar.current

    // creates a new date using the day of the passed in date (of: ...) but sets the
    // hour to noon (this is to avoid any issues with daylight saving time)
    guard
        let formattedTwoDaysAgoDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: twoDaysAgoDate),
        let formattedCurrentDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())
        else {
            return
    }
    
    /*
     we then calculate the difference in days between the two formatted dates.
     Since we set the dates from earlier to noon for both, we can check the abs
     difference in days (that is, 1 day = 24 hours difference between 2 dates)
     
     This allows us to check the difference in calendar days between two dates
     (ex: if the dateToCheck is 06/15/20 at 9:00 PM and the dateToCompare [typically
     the current Date()] is 06/16/20 at 10:00 AM, the difference in hours is
     13 hours, which isn't a full day. But with this method, both dates get set to
     12:00 PM [noon] for both days and now we can check for a difference of 24 hours)
     */
    let components = calendar.dateComponents([.day], from: formattedTwoDaysAgoDate, to: formattedCurrentDate)
    
    guard let daysSinceTwoDaysAgo = components.day else { return }
    
    print(daysSinceTwoDaysAgo) // should print 2 if the twoDaysAgoDate is 2
    // calendar days ago (e.g. current date = 06/17/20, twoDaysAgoDate = 06/15/20)
}

compareDates()
