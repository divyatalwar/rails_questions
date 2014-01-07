Time::DATE_FORMATS[:short]  = ->(time) { time.strftime("%e-%b-%y , %I:%M %p") }
EMAIL_FORMAT =  /\A([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})\Z/i