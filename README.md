# ReligiousSunriseSunset
This code calculates the times for when a religious prayer must be done. The prayer time depends on sunrise and sunset.


 Thank you so much for taking the time to look at my code! It really helps a lot!
 
 The project:
 There is a reigious event every day that is related to the sunrise and sunset timings. The event is that:
 
    There is a "window" period of 24 minutes which determines when the "best", "better" and "good" times are to do the prayers.
    
                The first cycle of "best" "better" and "good" begins at sunrise, and ends 3 windows after, or 72 mins later.
                The 2nd cycle begins 12 windows after sunrise, so 12 * 24 mins = 4 hrs 48 mins, and lasts until 18 * 24 mins after sunrise, so 7 hrs 12 mins after sunrise.
                
                The 3rd cycle begins at sunset, and ends 72 mins later.
            
 
            The problem with the code right now is on line 45, when I declare the currentLocation variable, it is stored as nil. This problem progresses to line 51, where I try to get the latitude from currentLocation, which doesn't work as it is nil. Line 51 is where the formal error is thrown. Could you please help me with this?
 
