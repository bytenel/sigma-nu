app.controller("MainCtrl", ["$scope", function ($scope) {
	$scope.eventSources =[ 
        {
            url: "https://www.google.com/calendar/feeds/sigmanueplam%40gmail.com/public/basic",
            className: 'gcal-event',           // an option!
            currentTimezone: 'America/Denver' // an option!
        },
    	{
            url: "http://www.google.com/calendar/feeds/usa__en%40holiday.calendar.google.com/public/basic",
            className: 'gcal-event',           // an option!
            currentTimezone: 'America/Denver' // an option!
    	}];
}]);